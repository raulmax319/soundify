//
//  PlayerViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class PlayerViewController: UIViewController {
  lazy var playerView: PlayerView = {
    let view = PlayerView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func loadView() {
    super.loadView()
    
    view = playerView
  }
}
