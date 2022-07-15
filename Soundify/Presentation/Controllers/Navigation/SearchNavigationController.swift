//
//  SearchNavigationController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class SearchNavigationController: UINavigationController {
  init() {
    let searchVc = SearchViewController()
    searchVc.navigationItem.largeTitleDisplayMode = .always
    searchVc.title = "Search"
    
    super.init(rootViewController: searchVc)
    setupNavButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SearchNavigationController {
  func setupNavButton() {
    tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
    navigationBar.tintColor = .label
    navigationBar.prefersLargeTitles = true
  }
}
