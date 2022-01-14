//
//  Item.swift
//  Soundify
//
//  Created by Raul Max on 12/01/22.
//

import Foundation

// MARK: - NewReleasesItem
struct NewReleasesItem: Codable {
  let album_type: AlbumType
  let avaliable_markets: [String]?
  let external_urls: ExternalUrls
  let href: String
  let id: String
  let images: [Image]
  let name, release_date: String
  let total_tracks: Int
  let type: AlbumType
  let uri: String?
  let artists: [Artist]
}

// MARK: - AlbumType
enum AlbumType: String, Codable {
  case album
  case single
}

// MARK: - PlaylistItem
struct PlaylistItem: Codable {
  let description: String
  let external_urls: ExternalUrls
  let id: String
  let images: [Image]
  let name: String
  let owner: Owner
}

// MARK: - Owner
struct Owner: Codable {
  let display_name: String
  let external_urls: ExternalUrls
  let id: String
}

