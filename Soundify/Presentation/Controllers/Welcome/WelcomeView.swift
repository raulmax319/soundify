//
//  WelcomeView.swift
//  Soundify
//
//  Created by Raul Max on 05/07/22.
//

import UIKit

class WelcomeView: UIView {
  let signInButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .white
    button.layer.borderWidth = 2
    button.clipsToBounds = true
    button.setTitle("Sign In with Spotify", for: .normal)
    button.titleLabel?.font = UIFont.regular(ofSize: 16)
    button.setTitleColor(UIColor.black, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemGreen
    setupChildViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private

extension WelcomeView {
  private func setupChildViews() {
    addSubview(signInButton)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      signInButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      signInButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
      signInButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
