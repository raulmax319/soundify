//
//  TracksModel.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import Foundation

struct TracksModel: Codable {
  let items: [TrackItem]
}

struct TrackItem: Codable {
  let track: AudioTrackModel
}
