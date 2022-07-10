//
//  TabBarCoordinator.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit

class TabBarCoordinator: Coordinator {
  internal var navigationController: UINavigationController
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = TabBarBaseViewController()
    navigationController.present(vc, animated: true)
  }
}
