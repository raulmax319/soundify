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
    delegate = self
    modalPresentationStyle = .fullScreen
    
    let viewControllers = [
      HomeNavigationController(),
      SearchNavigationController(),
      LibraryNavigationController()
    ]
    
    setViewControllers(viewControllers, animated: true)
  }
}

extension TabBarBaseViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideTransition(for: tabBarController.viewControllers ?? [])
  }
}
