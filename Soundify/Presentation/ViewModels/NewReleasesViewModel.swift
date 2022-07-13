//
//  NewReleasesViewModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

actor NewReleasesViewModel: ViewModel {
  private(set) var loader: NewReleasesLoader
  private(set) var data: NewReleasesModel?
  
  init() {
    self.loader = NewReleasesLoader()
  }
  
  func load() async {
    do {
      let result = try await loader.load()
      print(result)
      data = result
    } catch {
      // do nothing for now
    }
  }
}
