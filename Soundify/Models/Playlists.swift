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
