//
//  FeaturedPlaylistsCollectionLayoutSection.swift
//  Soundify
//
//  Created by Raul Max on 14/07/22.
//

import Foundation
import UIKit

class FeaturedPlaylistsCollectionLayoutSection: NSCollectionLayoutSection {
  private class var itemSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
  }
  
  private class var groupSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1/1.5))
  }
  
  convenience init() {
    let item = NSCollectionLayoutItem(layoutSize: Self.itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: Self.groupSize,
      subitem: item,
      count: 2
    )
    
    self.init(group: group)
    orthogonalScrollingBehavior = .continuous
  }
}

// MARK: - Private
extension FeaturedPlaylistsCollectionLayoutSection {
}
