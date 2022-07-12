//
//  LibraryViewController.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class LibraryViewController: UIViewController {
  lazy var libraryView: LibraryView = {
    let view = LibraryView()
    view.backgroundColor = .systemBackground
    
    return view
  }()
  
  override func loadView() {
    super.loadView()
    
    view = libraryView
  }
}
