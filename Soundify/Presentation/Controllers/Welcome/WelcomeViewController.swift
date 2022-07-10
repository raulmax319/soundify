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
  
  private func handleSignIn(success: Bool) {
    guard success else {
      let alert = UIAlertController(title: "Oops...", message: "Somgehing something", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      present(alert, animated: true)
      return
    }
  }
}
