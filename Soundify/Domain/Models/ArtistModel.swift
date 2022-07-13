//
//  ArtistModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

enum ArtistType: String, Codable {
  case artist
}

struct ArtistModel: Codable {
  let externalUrls: ExternalUrlsModel
  let id, name, href: String
  let type: ArtistType
  let uri: String?
}

extension ArtistModel {
  enum CodingKeys: String, CodingKey {
    case id, name, href, type, uri
    case externalUrls = "external_urls"
  }
}
