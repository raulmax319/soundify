//
//  Playlist.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

// MARK: - FeaturedPlaylistsResponse
struct FeaturedPlaylistsResponse: Codable {
    let playlists: Playlists
}

// MARK: - Playlists
struct Playlists: Codable {
    let items: [PlaylistItem]
}

struct PlaylistDetails: Codable {
  let description: String
  let external_urls: [String: String]
  let id: String
  let images: [Image]
  let name: String
  let `public`: Bool
  let tracks: PlaylistTracksResponse
}

struct PlaylistTracksResponse: Codable {
  let items: [PlaylistTrackItem]
}

struct PlaylistTrackItem: Codable {
  let track: AudioTrack
}
