//
//  AlbumDetailsLoader.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

class AlbumsDetailsLoader: Loader {
  public func load(for albumID: String) async throws -> AlbumModel {
    let response = await client.get(AlbumModel.self, to: "/albums/\(albumID)", params: nil)
    
    switch response {
    case .success(let model):
      return model
    case .failure(let error):
      throw error
    }
  }
}
