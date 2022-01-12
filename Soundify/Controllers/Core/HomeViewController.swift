//
//  ViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Home"
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
    fetchData()
  }
  
  private func fetchData() {
    ApiCaller.shared.getNewReleases { result in
      switch result {
      case .success(let _): break
      case .failure(let _): break
      }
    }
  }
  
  @objc func didTapSettings() {
    let vc = SettingsViewController()
    vc.title = "Settings"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
}

