//
//  GetCurrentUserProfile.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

class GetCurrentUserProfile {
  private let client: HttpClient
  
  init(with client: HttpClient) {
    self.client = client
  }
}

extension GetCurrentUserProfile: GetUser {
  func getUser() async -> UserModel? {
    let response = await client.get(UserModel.self, to: "/me", params: nil)
    
    switch response {
    case .success(let model):
      return model
    case .failure(_):
      return nil
    }
  }
}
