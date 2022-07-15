//
//  HttpGetClient.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

protocol HttpGetClient {
  func get<T: Decodable>(_ T: T.Type, to endPoint: String, params: [URLQueryItem]?) async -> Response<T>
}
