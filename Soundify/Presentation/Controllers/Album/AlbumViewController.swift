//
//  AlbumViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class AlbumViewController: UIViewController {
  private var album: AlbumModel
  
  lazy var albumView: AlbumView = {
    let view = AlbumView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  init(album: AlbumModel) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
    
    self.fetchPLaylist()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func loadView() {
    super.loadView()
    
    view = albumView
  }
}

// MARK: - Private
extension AlbumViewController {
  private func fetchPLaylist() {
    print(album)
  }
  
  private func setupView() {
    title = album.name
  }
}
