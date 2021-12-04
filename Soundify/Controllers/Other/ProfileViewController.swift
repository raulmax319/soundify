//
//  ProfileViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      title = "Profile"
      ApiCaller.shared.getCurrentUserProfile(completion: { result in
        switch result {
        case .success(let model):
          break
        case .failure(let error):
          print(error.localizedDescription)
        }
      })
    }
}
