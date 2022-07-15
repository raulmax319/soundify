//
//  AlbumCoordinator.swift
//  Soundify
//
//  Created by Raul Max on 15/07/22.
//

import Foundation
import UIKit

class AlbumCoordinator: NSObject, Coordinator {
  internal let navigationController: UINavigationController
  private let album: AlbumModel
  
  init(with navigationController: UINavigationController, album: AlbumModel) {
    self.navigationController = navigationController
    self.album = album
    super.init()
  }
  
  func start() {
    let albumVC = AlbumViewController(album: album)
    
    albumVC.navigationItem.largeTitleDisplayMode = .never
    navigationController.pushViewController(albumVC, animated: true)
  }
}
