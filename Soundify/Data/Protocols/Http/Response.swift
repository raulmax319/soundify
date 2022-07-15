//
//  Response.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

enum Response<T: Decodable> {
  case success(T)
  case failure(Error)
}
