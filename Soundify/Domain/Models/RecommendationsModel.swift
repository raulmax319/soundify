//
//  RecommendationsModel.swift
//  Soundify
//
//  Created by Raul Max on 13/07/22.
//

import Foundation

struct RecommendationsGenresModel: Codable {
  let genres: [String]
}

struct RecommendationsModel: Codable {
  let tracks: [AudioTrackModel]
}
