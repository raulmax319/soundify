//
//  UnexpectedError.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

class UnexpectedError: HttpError {
  init() {
    super.init(with: "Something went wrong with the request")
    self.name = "UnexpectedError"
  }
}
