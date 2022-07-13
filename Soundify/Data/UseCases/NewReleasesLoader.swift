//
//  NewReleasesLoader.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

class NewReleasesLoader: Loader {
  public func load() async throws -> NewReleasesModel {
    let response = await client.get(NewReleasesModel.self, to: "/browse/new-releases?limit=5", params: nil)
    
    switch response {
    case .success(let model):
      return model
    case .failure(let error):
      throw error
    }
  }
}
