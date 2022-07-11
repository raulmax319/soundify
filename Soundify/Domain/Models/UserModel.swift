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
  public var external_urls: [String : String]
  public var images: [ImageModel]
}
