//
//  Albums.swift
//  Soundify
//
//  Created by Raul Max on 12/01/22.
//

import Foundation

// MARK: - Albums
struct Albums: Codable {
  let href: String
  let items: [NewReleasesItem]
  let next: String
  let offset: Int
  let total: Int
}

struct Album: Codable {
  let album_type: String
  let artists: [Artist]
  let available_markets: [String]
  let external_urls: ExternalUrls
  let href, id: String
  let images: [Image]
  let name, release_date: String
  let total_tracks: Int
  let type, uri: String
}
