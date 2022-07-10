//
//  AppDelegate.swift
//  Soundify
//
//  Created by Raul Max on 05/07/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    let navigationController = UINavigationController()
    navigationController.navigationBar.prefersLargeTitles = true
    navigationController.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    
    if AuthenticationManager.shared.isSignedIn {
      Task.detached {
        let _ = await AuthenticationManager.shared.refreshAccessToken()
        print("should navigate to tab bar controller")
      }
    } else {
      let coordinator = WelcomeCoordinator(with: navigationController)
      coordinator.start()
    }
    
    self.window = window
    
    return true
  }
}

