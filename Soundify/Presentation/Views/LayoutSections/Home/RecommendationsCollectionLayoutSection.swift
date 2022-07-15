//
//  RecommendationsCollectionLayoutSection.swift
//  Soundify
//
//  Created by Raul Max on 14/07/22.
//

import Foundation
import UIKit

class RecommendationsCollectionLayoutSection: NSCollectionLayoutSection {
  private class var itemSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
  }
  
  private class var groupSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
  }
  
  convenience init() {
    let item = NSCollectionLayoutItem(layoutSize: Self.itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: Self.groupSize,
      subitem: item,
      count: 1
    )
    
    self.init(group: group)
    orthogonalScrollingBehavior = .continuous
  }
}

// MARK: - Private
extension RecommendationsCollectionLayoutSection {
}
