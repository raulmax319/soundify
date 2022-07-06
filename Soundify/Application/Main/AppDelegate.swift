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
    window.makeKeyAndVisible()
    
    let navigationController = UINavigationController()
    window.rootViewController = navigationController
    self.window = window
    
    let coordinator = WelcomeCoordinator(with: navigationController)
    coordinator.start()
    
    return true
  }
}

