//
//  RecommendationsLoader.swift
//  Soundify
//
//  Created by Raul Max on 13/07/22.
//

import Foundation

class RecommendationsLoader: Loader {
  public func load() async throws -> RecommendationsModel {
    let model = try await loadGenres()
    var seeds = Set<String>()
    
    while seeds.count < 5 {
      if let random = model.genres.randomElement() {
        seeds.insert(random)
      }
    }
    
    let response = await client.get(RecommendationsModel.self, to: "/recommendations?limit=40&seed_genres=\(seeds.joined(separator: ","))", params: nil)
    
    switch response {
    case .success(let model):
      return model
    case .failure(let error):
      throw error
    }
  }
}

extension RecommendationsLoader {
  private func loadGenres() async throws -> RecommendationsGenresModel {
    let result = await client.get(RecommendationsGenresModel.self, to: "/recommendations/available-genre-seeds", params: nil)
    
    switch result {
    case .success(let model):
      return model
    case .failure(let err):
      throw err
    }
  }
}
