//
//  SignInCoordinator.swift
//  Soundify
//
//  Created by Raul Max on 08/07/22.
//

import UIKit
import WebKit

class SignInCoordinator: NSObject, Coordinator {
  internal let navigationController: UINavigationController
  
  init(with navigationController: UINavigationController) {
    self.navigationController = navigationController
    super.init()
  }
  
  func start() {
    let signInVc = SignInViewController()
    signInVc.completionHandler = { [weak self] success in
      self?.handleSignIn(success: success)
    }
    
    signInVc.navigationItem.largeTitleDisplayMode = .never
    navigationController.pushViewController(signInVc, animated: true)
  }
}

// MARK: - Private
extension SignInCoordinator {
  private func handleSignIn(success: Bool) {
    guard success else {
      let alert = UIAlertController(title: "Oops...", message: "Somgehing something", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      navigationController.present(alert, animated: true)
      return
    }
    
    let mainAppTabBarVc = MainTabBarViewController()
    mainAppTabBarVc.modalPresentationStyle = .fullScreen
    navigationController.present(mainAppTabBarVc, animated: true)
  }
}
