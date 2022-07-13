//
//  HomeView.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit

enum BrowseSectionType {
  case newReleases(viewModel: [NewReleasesViewModel])
//  case featuredPlaylists(viewModel: [FeaturedPlaylistsViewModel])
//  case recommendedTracks(viewModel: [RecommendedTracksViewModel])
}

class HomeView: UIView {
  let collectionView: UICollectionView = {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
      return HomeView.createSectionLayout(for: sectionIndex)
    }
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return collectionView
  }()
  
  private var sections = [BrowseSectionType]()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeView {
  private func setupCollectionView() {
    addSubview(collectionView)
    collectionView.register(
      NewReleasesCollectionViewCell.self,
      forCellWithReuseIdentifier: NewReleasesCollectionViewCell.kReuseIdentifier
    )
    collectionView.register(
      FeaturedPlaylistsCollectionViewCell.self,
      forCellWithReuseIdentifier: FeaturedPlaylistsCollectionViewCell.kReuseIdentifier
    )
    collectionView.register(
      RecommendedTracksCollectionViewCell.self,
      forCellWithReuseIdentifier: RecommendedTracksCollectionViewCell.kReuseIdentifier
    )
    collectionView.delegate = self
    collectionView.dataSource = self
    
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
}

extension HomeView: UICollectionViewDelegate {}

extension HomeView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.kReuseIdentifier, for: indexPath)
  }
}

// MARK: - Collection Layout Sections
extension HomeView {
  static func createSectionLayout(for section: Int) -> NSCollectionLayoutSection {
    switch section {
    case 0:
      return HomeView.makeFirstSection()
    case 1:
      return HomeView.makeSecondSection()
    case 2:
      return HomeView.makeThirdSection()
    default:
      return HomeView.makeDefaultSection()
    }
  }
  
  static func makeFirstSection() -> NSCollectionLayoutSection {
    let itemLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let verticalGroupLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1.0)
    )
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: verticalGroupLayoutSize,
      subitem: item,
      count: 3
    )
    let horizontalGroupLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1.0)
    )
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: horizontalGroupLayoutSize,
      subitem: verticalGroup,
      count: 1
    )
    
    let section = NSCollectionLayoutSection(group: horizontalGroup)
    section.orthogonalScrollingBehavior = .groupPaging
    return section
  }
  
  static func makeSecondSection() -> NSCollectionLayoutSection {
    let size = 200.0
    let itemLayoutSize = NSCollectionLayoutSize(
      widthDimension: .estimated(size),
      heightDimension: .estimated(size)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let verticalGroupLayoutSize = NSCollectionLayoutSize(
      widthDimension: .estimated(size),
      heightDimension: .estimated(size * 2)
    )
    let verticalGroup = NSCollectionLayoutGroup.vertical(
      layoutSize: verticalGroupLayoutSize,
      subitem: item,
      count: 2
    )
    
    let horizontalGroupLayoutSize = NSCollectionLayoutSize(
      widthDimension: .estimated(size),
      heightDimension: .estimated(size * 2)
    )
    let horizontalGroup = NSCollectionLayoutGroup.horizontal(
      layoutSize: horizontalGroupLayoutSize,
      subitem: verticalGroup,
      count: 1
    )
    
    let section = NSCollectionLayoutSection(group: horizontalGroup)
    section.orthogonalScrollingBehavior = .continuous
    return section
  }
  
  static func makeThirdSection() -> NSCollectionLayoutSection {
    let itemLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .estimated(80)
    )
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: groupSize,
      subitem: item,
      count: 1
    )
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    return section
  }
  
  static func makeDefaultSection() -> NSCollectionLayoutSection {
    let itemLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalHeight(1.0)
    )
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let verticalGroupLayoutSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1.0),
      heightDimension: .fractionalWidth(1.0)
    )
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize: verticalGroupLayoutSize,
      subitem: item,
      count: 1
    )
    
    let section = NSCollectionLayoutSection(group: group)
    return section
  }
}
