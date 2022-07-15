//
//  AudioTrackModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

struct AudioTrackModel: Codable {
  let id, name: String
  let album: AlbumModel?
  let artists: [ArtistModel]
  let availableMarkets: [String]
  let discNumber: Int
  let durationMs: Int
  let externalUrls: ExternalUrlsModel
}

extension AudioTrackModel {
  enum CodingKeys: String, CodingKey {
    case id, name, album, artists
    case availableMarkets = "available_markets"
    case discNumber = "disc_number"
    case durationMs = "duration_ms"
    case externalUrls = "external_urls"
  }
}
