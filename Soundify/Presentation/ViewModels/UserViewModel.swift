//
//  UserViewModel.swift
//  Soundify
//
//  Created by Raul Max on 11/07/22.
//

import Foundation

actor UserViewModel: ViewModel {
  private(set) var loader: UserLoader
  private(set) var user: UserModel?
  
  init() {
    self.loader = UserLoader()
  }
  
  func load() async {
    do {
      let model = try await loader.load()
      user = model
    } catch {
      // do nothing for now
    }
  }
}
