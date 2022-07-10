//
//  StorageSaveClient.swift
//  Soundify
//
//  Created by Raul Max on 08/07/22.
//

import Foundation

protocol StorageSaveClient {
  func save(for key: String, value: Any)
}
