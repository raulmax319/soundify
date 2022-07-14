//
//  FeaturedPlaylistsModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

struct FeaturedPlaylistsModel: Codable {
  let playlists: PlaylistsModel
}

struct PlaylistsModel: Codable {
  let items: [PlaylistItemModel]
}

struct PlaylistItemModel: Codable {
  let id, name, description: String
  let externalUrls: ExternalUrlsModel
  let images: [ImageModel]
  let `public`: Bool?
  let tracks: PlaylistTracksItem
  let owner: OwnerModel
}

struct PlaylistTracksItem: Codable {
  let href: String
  let total: Int
}

struct OwnerModel: Codable {
  let displayName: String
  let externalUrls: ExternalUrlsModel
  let id: String
}

extension OwnerModel {
  enum CodingKeys: String, CodingKey {
    case id
    case displayName = "display_name"
    case externalUrls = "external_urls"
  }
}

extension PlaylistItemModel {
  enum CodingKeys: String, CodingKey {
    case id, name, description, images, `public`, tracks, owner
    case externalUrls = "external_urls"
  }
}
