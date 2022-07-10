//
//  Authentication.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

protocol Authentication {
  func auth(code: String) async -> Bool
  func refresh() async
}
