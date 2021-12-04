//
//  AuthManager.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

func readPlist(key: String) -> String {
  let path = Bundle.main.path(forResource: "Constants", ofType: "plist")
  let dict = NSDictionary(contentsOfFile: path!)
  
  let data = dict?.object(forKey: key) as! String
  
  return data
}

final class AuthManager {
  static let shared = AuthManager()
  
  
  
  struct Constants {
    static let clientID = readPlist(key: "clientID")
    static let clientSecret = readPlist(key: "clientSecret")
    static let baseURL = readPlist(key: "baseURL")
    static let scopes = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Constants", ofType: "plist")!)?.object(forKey: "scopes") as! [String]
    static let redirectURL = readPlist(key: "redirectURL")
    static let tokenURL = readPlist(key: "tokenURL")
    
  }
  
  private init() {}
  
  public var signInURL: URL? {
    print("\(Constants.baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes.joined(separator: "%20"))&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE")
    return URL(string: "\(Constants.baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes.joined(separator: "%20"))&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE")
  }
  
  var isSignedIn: Bool {
    return accessToken != nil
  }
  
  private var accessToken: String? {
    return UserDefaults.standard.string(forKey: "access_token")
  }
  
  private var refreshToken: String? {
    return UserDefaults.standard.string(forKey: "refresh_token")
  }
  
  private var expirationDate: Date? {
    return UserDefaults.standard.object(forKey: "expiration_date") as? Date
  }
  
  private var shouldRefreshToken: Bool {
    guard let expirationDate = expirationDate else {
      return false
    }
    let now = Date()
    return now.addingTimeInterval(300) >= expirationDate
    
  }
  
  public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
    guard let url = URL(string: Constants.tokenURL) else { return }
    
    var components = URLComponents()
    components.queryItems = [
      URLQueryItem(name: "grant_type", value: "authorization_code"),
      URLQueryItem(name: "code", value: code),
      URLQueryItem(name: "redirect_uri", value: Constants.redirectURL),
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = components.query?.data(using: .utf8)
    
    let basicToken = "\(Constants.clientID):\(Constants.clientSecret)".data(using: .utf8)
    guard let base64 = basicToken?.base64EncodedString() else {
      completion(false)
      return }
    request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, _, error in
      guard let data = data, error == nil else {
        completion(false)
        return
      }
      
      do {
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        self?.cacheToken(result: response)
        completion(true)
      } catch {
        print(error.localizedDescription)
        completion(false)
      }
    })
    
    task.resume()
  }
  
  // refresh when needed
  public func refreshAccessToken(completion: @escaping (Bool) -> Void) {
//    guard shouldRefreshToken else {
//      completion(true)
//      return
//    }
    guard let refreshToken = self.refreshToken else {
      return
    }
    
    // Refresh the token
    guard let url = URL(string: Constants.tokenURL) else {
      return
    }
    
    var components = URLComponents()
    components.queryItems = [
      URLQueryItem(name: "grant_type", value: "refresh_token"),
      URLQueryItem(name: "refresh_token", value: refreshToken)
    ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpBody = components.query?.data(using: .utf8)
    
    let basicToken = "\(Constants.clientID):\(Constants.clientSecret)".data(using: .utf8)
    guard let base64 = basicToken?.base64EncodedString() else {
      completion(false)
      return
    }
    
    request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: {
      [weak self] data, _, error in
      guard let data = data, error == nil else {
        completion(false)
        return
      }
      
      do {
        let response = try JSONDecoder().decode(AuthResponse.self, from: data)
        self?.cacheToken(result: response)
        completion(true)
      } catch {
        print(error.localizedDescription)
        completion(false)
      }
    })
    task.resume()
  }
  
  private func cacheToken(result: AuthResponse) {
    UserDefaults.standard.setValue(result.access_token, forKey: "access_token")

    if let refresh_token = result.refresh_token {
      UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
    }

    UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expiration_date")
  }
}
