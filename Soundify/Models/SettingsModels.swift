//
//  SettingsModels.swift
//  Soundify
//
//  Created by Raul Max on 04/12/21.
//

import Foundation

struct Section {
  let title: String
  let options: [Option]
}

struct Option {
  let title: String
  let handler: () -> Void
}
