//
//  AudioTrack.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

// MARK: - AudioTrack
struct AudioTrack: Codable {
  let album: Album
  let artists: [Artist]
  let available_markets: [String]
  let disc_number, duration_ms, popularity: Int
  let explicit: Bool
  let external_urls: ExternalUrls
  let id, name: String
}
