//
//  ProfileViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.isHidden = true
    return tableView
  }()
  
  private var models = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Profile"
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    fetchProfile()
    view.backgroundColor = .systemBackground
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  private func fetchProfile() {
    ApiCaller.shared.getCurrentUserProfile(completion: { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          self?.updateUI(with: model)
          break
        case .failure(let error):
          print(error.localizedDescription)
          self?.failedToGetProfile()
        }
      }
    })
  }
  
  private func updateUI(with model: User) {
    tableView.isHidden = false
    models.append("Full Name: \(model.display_name)")
    models.append("Email Address: \(model.display_name)")
    models.append("User ID: \(model.id)")
    models.append("Plan: \(model.product)")
    tableView.reloadData()
  }
  
  private func failedToGetProfile() {
    let label = UILabel(frame: .zero)
    label.text = "Failed to load profile."
    label.sizeToFit()
    label.textColor = .secondaryLabel
    view.addSubview(label)
    label.center = view.center
  }
  
  // MARK: - TableView
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = models[indexPath.row]
    cell.contentConfiguration = content
    cell.selectionStyle = .none
    return cell
  }
}
