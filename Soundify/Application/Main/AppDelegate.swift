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
    
    if AuthenticationManager.shared.isSignedIn {
      window.rootViewController = TabBarBaseViewController()
      Task {
        await RemoteAuthentication().refresh()
      }
    } else {
      let navigationController = UINavigationController()
      navigationController.navigationBar.prefersLargeTitles = true
      navigationController.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
      
      window.rootViewController = navigationController
      
      let coordinator = WelcomeCoordinator(with: navigationController)
      coordinator.start()
    }
    
    window.makeKeyAndVisible()
    self.window = window
    
    let viewMOdel = NewReleasesViewModel()
    Task {
      await viewMOdel.load()
    }
    
    return true
  }
}

