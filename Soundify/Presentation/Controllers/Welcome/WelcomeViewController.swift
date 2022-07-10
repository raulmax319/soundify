//
//  WelcomeViewController.swift
//  Soundify
//
//  Created by Raul Max on 05/07/22.
//

import UIKit

class WelcomeViewController: UIViewController {
  lazy var welcomeView: WelcomeView = {
    let view = WelcomeView()
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Soundify"
    welcomeView.signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
  }
  
  override func loadView() {
    view = welcomeView
  }
}

extension WelcomeViewController {
  @objc func didTapSignInButton() {
    SignInCoordinator(with: navigationController!).start()
  }
}
