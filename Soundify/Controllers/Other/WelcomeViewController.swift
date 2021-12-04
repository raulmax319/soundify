//
//  WelcomeViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  private let signInButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .none
    button.layer.borderWidth = 2
    button.clipsToBounds = true
    button.setTitle("Sign In with Spotify".uppercased(), for: .normal)
    button.setTitleColor(.systemBackground, for: .normal)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Soundify"
    view.backgroundColor = .systemGreen
    view.addSubview(signInButton)
    signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    signInButton.frame = CGRect(x: 20, y: view.height - 50 - view.safeAreaInsets.bottom, width: view.width - 40, height: 50)
    signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
  }
  
  @objc func didTapSignIn() {
    let authVc = AuthViewController()
    authVc.completionHandler = { [weak self] success in
      self?.handleSignIn(success: success)
    }
    authVc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(authVc, animated: true)
  }
  
  private func handleSignIn(success: Bool) {
    // Login or yell at the user
    guard success else {
      let alert = UIAlertController(title: "Oops...", message: "Something went wrong when trying to signing in.", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
      present(alert, animated: true)
      return
    }
    
    let mainAppTabBarVc = TabBarViewController()
    mainAppTabBarVc.modalPresentationStyle = .fullScreen
    present(mainAppTabBarVc, animated: true)
  }
}
