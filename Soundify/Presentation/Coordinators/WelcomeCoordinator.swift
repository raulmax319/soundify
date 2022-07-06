//
//  LoginCoordinator.swift
//  Soundify
//
//  Created by Raul Max on 05/07/22.
//

import UIKit

class WelcomeCoordinator: Coordinator {
  let navigation: UINavigationController
  
  init(with navigationController: UINavigationController) {
    self.navigation = navigationController
  }
  
  func start() {
    let welcomeVc = WelcomeViewController()
    
    navigation.pushViewController(welcomeVc, animated: true)
  }
}
