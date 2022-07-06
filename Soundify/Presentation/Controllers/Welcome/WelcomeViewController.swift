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
  
  override func loadView() {
    view = welcomeView
  }
}
