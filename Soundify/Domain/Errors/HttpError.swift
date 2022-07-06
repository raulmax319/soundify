//
//  HttpError.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

class HttpError: Error {
  let message: String
  var name: String = "Generic Error"
  
  init(with message: String) {
    self.message = message
  }
}
