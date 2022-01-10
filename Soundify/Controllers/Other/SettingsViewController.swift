//
//  SettingsViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
  }()
  
  private var sections = [Section]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
    title = "Settings"
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func configureModels() {
    sections.append(Section(title: "Profile", options: [Option(title: "View your Profile", handler: {
      [weak self] in
      DispatchQueue.main.async {
        self?.viewProfile()
      }
    })]))
    
    sections.append(Section(title: "Account", options: [Option(title: "Sign Out", handler: {
      [weak self] in
      DispatchQueue.main.async {
        self?.signOutTapped()
      }
    })]))
  }
  
  private func signOutTapped() {}
  
  private func viewProfile() {
    let vc = ProfileViewController()
    vc.title = "Profile"
    navigationController?.pushViewController(vc, animated: true)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  // MARK: TableView
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].options.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sections[indexPath.section].options[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = model.title
    cell.contentConfiguration = content
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    // Call handler for cell
    let model = sections[indexPath.section].options[indexPath.row]
    model.handler()
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let model = sections[section]
    return model.title
  }
}
