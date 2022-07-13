//
//  NewReleasesModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

struct NewReleasesModel: Codable {
  let albums: NewReleasesAlbumModel
}

struct NewReleasesAlbumModel: Codable {
  let href, next: String
  let offset, total: Int
  let items: [AlbumModel]
}
