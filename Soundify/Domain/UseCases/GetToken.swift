//
//  GetToken.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

protocol GetToken {
  func exchangeCodeForToken(code: String) async -> AccountModel
}
