//
//  RecommendationsViewModel.swift
//  Soundify
//
//  Created by Raul Max on 13/07/22.
//

import Foundation

actor RecommendationsViewModel: ViewModel {
  private(set) var loader: RecommendationsLoader
  private(set) var model: RecommendationsModel?
  
  init() {
    self.loader = RecommendationsLoader()
  }
  
  func load() async {
    do {
      let result = try await loader.load()
      model = result
    } catch {
      // do nothing for now
      print("Recommendations:")
      print(error.localizedDescription)
    }
  }
}
