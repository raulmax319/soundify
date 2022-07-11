//
//  GetCurrentUserProfile.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

protocol GetUser {
  func getUser() async -> UserModel?
}
