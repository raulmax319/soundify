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
  
  override func loadView() {
    super.loadView()
    
    view = homeView
  }
}
