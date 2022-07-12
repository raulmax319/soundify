//
//  GetCurrentUserProfile.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

class UserLoader {
  private let client: HttpClient
  
  init(with client: HttpClient = .shared) {
    self.client = client
  }
}

extension UserLoader {
  public func load() async throws -> UserModel {
    let response = await client.get(UserModel.self, to: "/me", params: nil)
    
    switch response {
    case .success(let model):
      return model
    case .failure(let error):
      throw error
    }
  }
}
