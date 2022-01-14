//
//  Recommendations.swift
//  Soundify
//
//  Created by Raul Max on 13/01/22.
//

import Foundation

// MARK: - RecommendedGenresResponse
struct RecommendedGenresResponse: Codable {
  let genres: [String]
}

// MARK: - RecommendationsResponse
struct RecommendationsResponse: Codable {
  let tracks: [AudioTrack]
}
