//
//  GetCurrentUserProfile.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

class UserLoader: Loader {
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
