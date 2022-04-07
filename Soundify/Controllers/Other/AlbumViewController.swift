//
//  AlbumViewController.swift
//  Soundify
//
//  Created by Raul Max on 07/04/22.
//

import UIKit

class AlbumViewController: UIViewController {
  
  private let album: NewReleasesItem
  
  init(album: NewReleasesItem) {
    self.album = album
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = album.name
    view.backgroundColor = .systemBackground
    
    ApiCaller.shared.getAlbumsDetails(for: album) {
      result in
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          break
        case .failure(let model):
          break
        }
      }
    }
  }
}
