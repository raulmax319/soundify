//
//  Coordinator.swift
//  Soundify
//
//  Created by Raul Max on 05/07/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get }
  func start()
}
