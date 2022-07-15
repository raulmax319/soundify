//
//  StorageLoadClient.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation

protocol StorageLoadClient {
  func loadString(for key: String) -> String?
  func load<T>(_: T.Type, for key: String) -> T?
}
