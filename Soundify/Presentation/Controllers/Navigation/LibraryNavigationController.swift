//
//  LibraryNavigationController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class LibraryNavigationController: UINavigationController {
  init() {
    let libraryVc = LibraryViewController()
    libraryVc.navigationItem.largeTitleDisplayMode = .always
    libraryVc.title = "Library"
    
    super.init(rootViewController: libraryVc)
    setupNavButton()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LibraryNavigationController {
  func setupNavButton() {
    tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 1)
    navigationBar.tintColor = .label
    navigationBar.prefersLargeTitles = true
  }
}
