//
//  AccountModel.swift
//  Soundify
//
//  Created by Raul Max on 08/07/22.
//

import Foundation

struct AccountModel: Codable {
  public var accessToken: String?
  public var expiresIn: Int?
  public var refreshToken: String?
  public var scope: String?
  public var tokenType: String?
}

extension AccountModel {
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case expiresIn = "expires_in"
    case refreshToken = "refresh_token"
    case scope
    case tokenType = "token_type"
  }
}
