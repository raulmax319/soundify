//
//  Artist.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let external_urls: ExternalUrls
    let href: String
    let id, name: String
    let type: ArtistType
    let uri: String
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

enum ArtistType: String, Codable {
    case artist
}
