//
//  AlbumModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

struct AlbumModel: Codable {
  let albumType: AlbumType
  let availableMarkets: [String]?
  let externalUrls: ExternalUrlsModel
  let id, name, href: String
  let images: [ImageModel]
  let releaseDate: String
  let totalTracks: Int
  let type: AlbumType
  let label, uri: String?
  let artists: [ArtistModel]
}

enum AlbumType: String, Codable {
  case album, ALBUM
  case single, SINGLE
  case compilation, COMPILATION
}

extension AlbumModel {
  enum CodingKeys: String, CodingKey {
    case id, name, href, uri, artists, images, type, label
    case albumType = "album_type"
    case availableMarkets = "available_markets"
    case externalUrls = "external_urls"
    case releaseDate = "release_date"
    case totalTracks = "total_tracks"
  }
}
