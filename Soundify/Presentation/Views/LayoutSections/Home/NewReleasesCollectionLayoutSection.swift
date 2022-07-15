//
//  NewReleasesCollectionLayoutSection.swift
//  Soundify
//
//  Created by Raul Max on 14/07/22.
//

import Foundation
import UIKit

class NewReleasesCollectionLayoutSection: NSCollectionLayoutSection {
  private class var itemSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
  }
  
  private class var verticalGroupLayoutSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
  }
  
  private class var horizontalGroupLayoutSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
  }
  
  private class var item: NSCollectionLayoutItem {
    let item = NSCollectionLayoutItem(layoutSize: Self.itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    return item
  }
  
  convenience init() {
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: Self.verticalGroupLayoutSize,
      subitem: Self.item,
      count: 3
    )
    
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: Self.horizontalGroupLayoutSize,
      subitem: verticalGroup,
      count: 1
    )
    
    self.init(group: horizontalGroup)
    orthogonalScrollingBehavior = .continuous
  }
}

// MARK: - Private
extension NewReleasesCollectionLayoutSection {
}
