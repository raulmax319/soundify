//
//  RemoteAuthentication.swift
//  Soundify
//
//  Created by Raul Max on 08/07/22.
//

import Foundation

class RemoteAuthentication {
  let manager: AuthenticationManager
  
  init(with manager: AuthenticationManager = .shared) {
    self.manager = manager
  }
}

extension RemoteAuthentication: Authentication {
  func auth(code: String) async -> Bool {
    let model = await manager.exchangeCodeForToken(code: code)

    let storage: StorageClient = .shared
    
    guard let accessToken = model.accessToken else {
      return false
    }
    storage.save(for: "access_token", value: accessToken)
    
    guard let refreshToken = model.refreshToken  else {
      return false
    }
    storage.save(for: "refresh_token", value: refreshToken)
    
    guard let expiresIn = model.expiresIn else {
      return false
    }
    
    let date = Date().addingTimeInterval(TimeInterval(expiresIn))
    storage.save(for: "expiration_date", value: date)

    return true
  }
}
