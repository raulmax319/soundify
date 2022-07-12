//
//  ProfileViewController.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit
import BubbleTask

class ProfileViewController: UIViewController {
  lazy var profileView: ProfileView = {
    let view = ProfileView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    profileView.fetchProfile()
  }
  
  override func loadView() {
    super.loadView()
    
    view = profileView
  }
}
