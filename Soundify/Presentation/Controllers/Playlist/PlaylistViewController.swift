//
//  PlaylistViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class PlaylistViewController: UIViewController {
  private let playlist: PlaylistItemModel
  
  lazy var playlistView: PlaylistView = {
    let view = PlaylistView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  init(playlist: PlaylistItemModel) {
    self.playlist = playlist
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
    
    view = playlistView
  }
}

// MARK: - Private
extension PlaylistViewController {
  private func fetchPLaylist() {
    print(playlist)
  }
  
  private func setupView() {
    title = playlist.name
  }
}
