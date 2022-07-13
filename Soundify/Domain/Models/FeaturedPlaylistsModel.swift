//
//  FeaturedPlaylistsModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

struct FeaturedPlaylistsModel: Codable {
  let playlists: Playlists
}

struct Playlists: Codable {
  let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
  let id, name, description: String
  let externalUrls: ExternalUrlsModel
  let images: [ImageModel]
  let `public`: Bool
  let tracks: TracksModel
}

extension PlaylistItem {
  enum CodingKeys: String, CodingKey {
    case id, name, description, images, `public`, tracks
    case externalUrls = "external_urls"
  }
}
