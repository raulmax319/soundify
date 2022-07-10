//
//  StorageClient.swift
//  Soundify
//
//  Created by Raul Max on 08/07/22.
//

import Foundation

class StorageClient {
  static let shared: StorageClient = StorageClient()
  
  private init () {}
}

extension StorageClient: StorageSaveClient {
  func save(for key: String, value: Any) {
    UserDefaults.standard.set(value, forKey: key)
  }
}

extension StorageClient: StorageLoadClient {
  func load<T>(_: T.Type,for key: String) -> T? {
    return UserDefaults.standard.object(forKey: key) as? T
  }
  
  func loadString(for key: String) -> String? {
    return UserDefaults.standard.string(forKey: key)
  }
}
