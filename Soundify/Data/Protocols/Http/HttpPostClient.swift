//
//  HttpPostClient.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

protocol HttpPostClient {
  func post<T: Decodable>(_ T: T.Type, to endPoint: String, body: [String: Any]?) async -> Response<T>
}
