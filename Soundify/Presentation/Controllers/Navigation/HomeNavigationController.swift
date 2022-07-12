//
//  HomeNavigationController.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit

class HomeNavigationController: UINavigationController {
  init() {
    let homeVc = HomeViewController()
    homeVc.navigationItem.largeTitleDisplayMode = .always
    homeVc.title = "Browse"
    
    super.init(rootViewController: homeVc)
    setupGearButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeNavigationController {
  func setupGearButton() {
    tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
    navigationBar.tintColor = .label
    navigationBar.prefersLargeTitles = true
  }
}
