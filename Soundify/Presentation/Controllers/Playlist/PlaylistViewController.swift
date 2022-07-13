//
//  PlaylistViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class PlaylistViewController: UIViewController {
  lazy var playlistView: PlaylistView = {
    let view = PlaylistView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func loadView() {
    super.loadView()
    
    view = playlistView
  }
}
