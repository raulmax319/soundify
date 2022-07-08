//
//  LoginCoordinator.swift
//  Soundify
//
//  Created by Raul Max on 05/07/22.
//

import UIKit

class WelcomeCoordinator: Coordinator {
  internal let navigationController: UINavigationController
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    navigationController.pushViewController(WelcomeViewController(), animated: true)
  }
}
