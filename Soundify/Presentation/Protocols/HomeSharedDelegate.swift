//
//  HomeSharedDelegate.swift
//  Soundify
//
//  Created by Raul Max on 15/07/22.
//

import Foundation

protocol HomeSharedDelegate: AnyObject {
  func navigateToPlaylistScreen(playlist: PlaylistItemModel)
  func navigateToAlbumScreen(album: AlbumModel)
  func navigateToRecommendationsScreen(track: AudioTrackModel)
}
