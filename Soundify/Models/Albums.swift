//
//  Albums.swift
//  Soundify
//
//  Created by Raul Max on 12/01/22.
//

import Foundation

// MARK: - Albums
struct Albums: Codable {
  let href: String
  let items: [Item]?
  let next: String
  let offset: Int
  let total: Int
}
