//
//  UserProfile.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

struct User: Codable {
  let country: String
  let email: String
  let display_name: String
  let explicit_content: [String: Bool]
  let external_urls: [String: String]
  // let followers: [String: Int]
  let id: String
  let product: String
  let images: [Image]
}
