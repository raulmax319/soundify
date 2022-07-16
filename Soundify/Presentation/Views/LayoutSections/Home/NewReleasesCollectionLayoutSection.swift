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
  
  private class var groupSize: NSCollectionLayoutSize {
    return NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1/1.5))
  }
  
  private class var header: NSCollectionLayoutBoundarySupplementaryItem {
    return NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(50)
      ),
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .topLeading
    )
  }
  
  convenience init() {
    let item = NSCollectionLayoutItem(layoutSize: Self.itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: Self.groupSize,
      subitem: item,
      count: 2
    )
    
    self.init(group: group)
    orthogonalScrollingBehavior = .continuous
    self.boundarySupplementaryItems = [Self.header]
  }
}

// MARK: - Private
extension NewReleasesCollectionLayoutSection {}
