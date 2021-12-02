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
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
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
    }
}
