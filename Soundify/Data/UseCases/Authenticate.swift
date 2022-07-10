//
//  Authenticate.swift
//  Soundify
//
//  Created by Raul Max on 08/07/22.
//

import Foundation

class Authenticate {
  let manager: AuthenticationManager
  
  init(with manager: AuthenticationManager = .shared) {
    self.manager = manager
  }
}

extension Authenticate: Authentication {
  func auth(code: String) async -> Bool {
    let result = await manager.exchangeCodeForToken(code: code)
    
    guard let model = result else { return false }
    
    let storage: StorageClient = .shared
    
    storage.save(for: "access_token", value: model.accessToken!)
    
    if let refreshToken = model.refreshToken {
      storage.save(for: "refresh_token", value: refreshToken)
    }
    let date = Date().addingTimeInterval(TimeInterval(model.expiresIn!))
    storage.save(for: "expiration_date", value: date)
    
    return true
  }
}
