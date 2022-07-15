//
//  SearchViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class SearchViewController: UIViewController {
  lazy var searchView: SearchView = {
    let view = SearchView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func loadView() {
    super.loadView()
    
    view = searchView
  }
}
