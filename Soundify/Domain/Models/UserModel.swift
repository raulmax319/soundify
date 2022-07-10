//
//  UserModel.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

struct UserModel: Codable {
  let id, product, country, email: String
  let displayName: String
  let explicitContent: [String : Bool]
  let external_urls: [String : String]
  let images: [ImageModel]
}
