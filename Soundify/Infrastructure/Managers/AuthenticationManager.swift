//
//  AuthenticationManager.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation
import BubbleTask

final class AuthenticationManager {
  static let shared = AuthenticationManager()
  
  private let httpClient: BubbleTask
  
  private init() {
    let config = AuthenticationManager.configureHttpClient()
    self.httpClient = BubbleTask(with: config)
  }
  
  private var refreshingToken = false
  
  public var signInURL: URL? {
    return URL(
      string: "\(Constants.authURL)/authorize?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes.joined(separator: "%20"))&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE"
    )
  }
  
  var isSignedIn: Bool {
    return accessToken != nil
  }
  
  private var accessToken: String? {
    return StorageClient.shared.loadString(for: "access_token")
  }
  
  private var refreshToken: String? {
    return StorageClient.shared.loadString(for: "refresh_token")
  }
  
  private var tokenExpirationDate: Date? {
    return StorageClient.shared.load(Date.self, for: "expiration_date")
  }
  
  private var shouldRefreshToken: Bool {
    guard let tokenExpirationDate = tokenExpirationDate else {
      return false
    }
    
    let currentTime = Date()
    let minutes: TimeInterval = 300
    return currentTime.addingTimeInterval(minutes) >= tokenExpirationDate
  }
}

// MARK: - Private
extension AuthenticationManager {
  private func getToken(with query: [URLQueryItem]) async throws -> AccountModel? {
    var components = URLComponents()
    components.queryItems = query
    
    let response = try await httpClient.post(to: "/api/token", with: components.query?.data(using: .utf8))
    
    guard let data = response.body else { return nil }
    
    do {
      let result = try JSONDecoder().decode(AccountModel.self, from: data)
      return result
    } catch {
      return nil
    }
  }
  
  class private func configureHttpClient() -> BubbleTaskConfig {
    let basicToken = "\(Constants.clientID):\(Constants.clientSecret)".data(using: .utf8)
    guard let base64 = basicToken?.base64EncodedString() else {
      fatalError("Failed to create basic token.")
    }
    
    let allHeaders: [String: String] = [
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization": "Basic \(base64)"
    ]
    
    let config = BubbleTaskConfig(baseUrl: Constants.authURL, headers: allHeaders)
    
    return config
  }
}

// MARK: - GetToken
extension AuthenticationManager: GetToken {
  func exchangeCodeForToken(code: String) async -> AccountModel {
    let body = [
      URLQueryItem(name: "grant_type", value: "authorization_code"),
      URLQueryItem(name: "code", value: code),
      URLQueryItem(name: "redirect_uri", value: "https://raulmax319.netlify.app")
    ]
    
    do {
      let res = try await getToken(with: body)
      return .init(
        accessToken: res?.accessToken,
        expiresIn: res?.expiresIn,
        refreshToken: res?.refreshToken,
        scope: res?.scope,
        tokenType: res?.tokenType
      )
    } catch {
      print("🛑 Error: \(error.localizedDescription)")
      return .init()
    }
  }
}
