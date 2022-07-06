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
