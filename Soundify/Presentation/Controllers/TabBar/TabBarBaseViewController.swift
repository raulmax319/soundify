//
//  TabBarBaseViewController.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit

class TabBarBaseViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    modalPresentationStyle = .fullScreen
    
    let homeNav = HomeNavigationController()
    
    setViewControllers([homeNav], animated: true)
  }
}
