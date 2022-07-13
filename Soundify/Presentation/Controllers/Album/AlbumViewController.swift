//
//  AlbumViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class AlbumViewController: UIViewController {
  lazy var albumView: AlbumView = {
    let view = AlbumView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func loadView() {
    super.loadView()
    
    view = albumView
  }
}
