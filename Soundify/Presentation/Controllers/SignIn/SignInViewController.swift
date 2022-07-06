//
//  SignInViewController.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import UIKit

class SignInViewController: UIViewController {
  lazy var signInView: SignInView = {
    let view = SignInView()
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Sign In"
  }
  
  override func loadView() {
    super.loadView()
    view = signInView
  }
}
