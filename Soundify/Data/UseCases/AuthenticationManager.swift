//
//  AuthenticationManager.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

final class AuthenticationManager {
  static let shared = AuthenticationManager()
  
  private init() {}
  
  public var signInURL: URL? {
    return URL(
      string: "\(Constants.signInURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes.joined(separator: "%20"))&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE"
    )
  }
  
  var isSignedIn: Bool {
    return false
  }
  
  private var accessToken: String? {
    return nil
  }
  
  private var refreshToken: String? {
    return nil
  }
  
  private var tokenExpirationDate: Date? {
    return nil
  }
  
  private var shouldRefreshToken: Bool? {
    return false
  }
}

extension AuthenticationManager: Authentication {
  func auth() async -> String {
    return ""
  }
}
