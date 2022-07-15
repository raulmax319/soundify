//
//  PlaylistCoordinator.swift
//  Soundify
//
//  Created by Raul Max on 15/07/22.
//

import Foundation
import UIKit

class PlaylistCoordinator: NSObject, Coordinator {
  internal let navigationController: UINavigationController
  private let playlist: PlaylistItemModel
  
  init(with navigationController: UINavigationController, playlist: PlaylistItemModel) {
    self.navigationController = navigationController
    self.playlist = playlist
    super.init()
  }
  
  func start() {
    let playlistVc = PlaylistViewController(playlist: playlist)
    
    playlistVc.navigationItem.largeTitleDisplayMode = .never
    navigationController.pushViewController(playlistVc, animated: true)
  }
}
