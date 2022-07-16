//
//  HomeViewController.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit

class HomeViewController: UIViewController {
  lazy var homeView: HomeView = {
    let view = HomeView()
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let gear = UIBarButtonItem(
      image: UIImage(systemName: "gear"),
      style: .done,
      target: self,
      action: #selector(didTapSettings)
    )
    navigationItem.rightBarButtonItem = gear
  }
  
  override func loadView() {
    super.loadView()

    view = homeView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    homeView.fetchData()
    homeView.delegate = self
  }
}

extension HomeViewController {
  @objc func didTapSettings() {
    TabBarCoordinator(with: navigationController!).navigateToProfile()
  }
}

extension HomeViewController: HomeSharedDelegate {
  func navigateToPlaylistScreen(playlist: PlaylistItemModel) {
    let coordinator = PlaylistCoordinator(with: navigationController!, playlist: playlist)
    coordinator.start()
  }
  
  func navigateToAlbumScreen(album: AlbumModel) {
    let coordinator = AlbumCoordinator(with: navigationController!, album: album)
    coordinator.start()
  }
  
  func navigateToRecommendationsScreen(track: AudioTrackModel) {}
}
