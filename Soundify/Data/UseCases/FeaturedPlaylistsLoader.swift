//
//  FeaturedPlaylistsLoader.swift
//  Soundify
//
//  Created by Raul Max on 13/07/22.
//

import Foundation

class FeaturedPlaylistsLoader: Loader {
  public func load() async throws -> FeaturedPlaylistsModel {
    let response = await client.get(FeaturedPlaylistsModel.self, to: "/browse/featured-playlists?limit=5", params: nil)
    
    switch response {
    case .success(let model):
      return model
    case .failure(let error):
      throw error
    }
  }
}
