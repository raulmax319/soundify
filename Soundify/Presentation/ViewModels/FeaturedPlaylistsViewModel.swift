//
//  FeaturedPlaylistsViewModel.swift
//  Soundify
//
//  Created by Raul Max on 13/07/22.
//

import Foundation

actor FeaturedPlaylistsViewModel: ViewModel {
  private(set) var loader: FeaturedPlaylistsLoader
  private(set) var model: FeaturedPlaylistsModel?
  
  init() {
    self.loader = FeaturedPlaylistsLoader()
  }
  
  func load() async {
    do {
      let result = try await loader.load()
      model = result
    } catch {
      // do nothing for now
      print("Featured PLaylists:")
      print(error.localizedDescription)
    }
  }
}
