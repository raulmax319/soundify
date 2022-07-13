//
//  Loader.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

class Loader {
  let client: HttpClient
  
  init(with client: HttpClient = .shared) {
    self.client = client
  }
}
