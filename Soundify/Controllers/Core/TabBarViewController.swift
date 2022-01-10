//
//  TabBarViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let homeVc = HomeViewController()
    let searchVc = SearchViewController()
    let libraryVc = LibraryViewController()
    
    homeVc.title = "Browse"
    searchVc.title = "Search"
    libraryVc.title = "Library"
    
    homeVc.navigationItem.largeTitleDisplayMode = .always
    searchVc.navigationItem.largeTitleDisplayMode = .always
    libraryVc.navigationItem.largeTitleDisplayMode = .always
    
    let navHome = UINavigationController(rootViewController: homeVc)
    let navSearch = UINavigationController(rootViewController: searchVc)
    let navLib = UINavigationController(rootViewController: libraryVc)
    
    navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
    navHome.navigationBar.tintColor = .label
    
    navSearch.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
    navLib.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
    
    navHome.navigationBar.prefersLargeTitles = true
    navSearch.navigationBar.prefersLargeTitles = true
    navLib.navigationBar.prefersLargeTitles = true
    
    setViewControllers([navHome, navSearch, navLib], animated: false)
  }
}
