//
//  PlaylistViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class PlaylistViewController: UIViewController {
  private let playlist: PlaylistItem
  
  init(playlist: PlaylistItem) {
    self.playlist = playlist
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = playlist.name
    view.backgroundColor = .systemBackground
    ApiCaller.shared.getPlaylistsDetails(for: playlist) {
      result in
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          break
        case .failure(let model):
          break
        }
      }
    }
  }
}
