//
//  NoDataError.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

class NoDataError: HttpError {
  init() {
    super.init(with: "Failed to decode data.")
    self.name = "NoDataError"
  }
}
