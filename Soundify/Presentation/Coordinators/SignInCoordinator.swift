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
    signInVc.signInView.navigationDelegate = self
    
    guard let url = AuthenticationManager.shared.signInURL else { return }
  }
}

extension SignInCoordinator: WKNavigationDelegate {}
