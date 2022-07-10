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
    
    guard let url = AuthenticationManager.shared.signInURL else { return }
    signInVc.signInView.load(URLRequest(url: url))
    
    signInVc.navigationItem.largeTitleDisplayMode = .never
    navigationController.pushViewController(signInVc, animated: true)
  }
}
