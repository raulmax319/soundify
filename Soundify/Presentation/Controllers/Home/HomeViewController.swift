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
    view.backgroundColor = .systemBackground
    
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
}

extension HomeViewController {
  @objc func didTapSettings() {
    TabBarCoordinator(with: navigationController!).navigateToProfile()
  }
}
