//
//  UserModel.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

struct UserModel: Codable {
  public var id, product, country, email: String
  public var displayName: String
  public var explicitContent: [String : Bool]
  public var externalUrls: [String : String]
  public var images: [ImageModel]
}

extension UserModel {
  enum CodingKeys: String, CodingKey {
    case id, product, country, email, images
    case displayName = "display_name"
    case explicitContent = "explicit_content"
    case externalUrls = "external_urls"
  }
}
