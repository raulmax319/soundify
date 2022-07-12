//
//  ProfileView.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit
import SDWebImage

class ProfileView: UIView {
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.isHidden = true
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    return tableView
  }()
  
  private var models = [String]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    tableView.delegate = self
    tableView.dataSource = self
    addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: self.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ProfileView: UITableViewDelegate {}

extension ProfileView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    if #available(iOS 14.0, *) {
      var content = cell.defaultContentConfiguration()
      content.text = models[indexPath.row]
      content.textProperties.font = UIFont.regular(ofSize: 16)
      cell.contentConfiguration = content
    } else {
      cell.textLabel?.text = models[indexPath.row]
    }
    
    cell.selectionStyle = .none
    
    return cell
  }
}

// MARK: - Private
extension ProfileView {
  private func onFail() {
    let label = UILabel(frame: .zero)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Failed to load profile."
    label.sizeToFit()
    label.textColor = .secondaryLabel
    
    addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
  
  private func createTableHeader(with string: String?) {
    guard let urlStr = string, let url = URL(string: urlStr) else { return }
    
    let headerView = UIView()
    headerView.translatesAutoresizingMaskIntoConstraints = false
    
    let imageSize: CGFloat = headerView.height / 2
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.sd_setImage(with: url, completed: nil)
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = imageSize / 2
    
    headerView.addSubview(imageView)
    tableView.tableHeaderView = headerView
    
    NSLayoutConstraint.activate([
      headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      headerView.heightAnchor.constraint(equalToConstant: self.width / 1.5),
      imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: imageSize),
      imageView.heightAnchor.constraint(equalToConstant: imageSize)
    ])
  }
  
  @MainActor private func updateUI(with item: UserModel) {
    tableView.isHidden = false
    
    models.append("Full Name: \(item.displayName)")
    models.append("Email: \(item.email)")
    models.append("User ID: \(item.id)")
    models.append("Plan: \(item.product)")
    createTableHeader(with: item.images.first?.url)
    tableView.reloadData()
  }
}

// MARK: - Public
extension ProfileView {
  public func fetchProfile() {
    let userViewModel = UserViewModel()
    
    Task {
      await userViewModel.load()
      
      if let userModel = await userViewModel.user {
        await MainActor.run {
          self.updateUI(with: userModel)
        }
      } // MainActor
    } // Task
  }
}
