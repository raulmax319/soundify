//
//  SearchResultViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class SearchResultViewController: UIViewController {
  lazy var searchResultView: SearchResultView = {
    let view = SearchResultView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func loadView() {
    super.loadView()
    
    view = searchResultView
  }
}
