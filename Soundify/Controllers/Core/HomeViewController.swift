//
//  ViewController.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import UIKit

enum BrowseSectionType {
  case newReleases(viewModel: [NewReleasesCell])
  case featuredPlaylists(viewModel: [NewReleasesCell])
  case recommendedTracks(viewModel: [NewReleasesCell])
}

class HomeViewController: UIViewController {
  
  private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
    return HomeViewController.createSectionLayout(section: sectionIndex)
  })
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView()
    spinner.tintColor = .label
    spinner.hidesWhenStopped = true
    
    return spinner
  }()
  
  private var sections = [BrowseSectionType]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Browse"
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
    configureCollectionView()
    view.addSubview(spinner)
    fetchData()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
  
  private func configureCollectionView() {
    view.addSubview(collectionView)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.register(NewReleaseCollectionViewCell.self, forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
    collectionView.register(FeaturedPlaylistCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
    collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  // Featured Playlists, Recommended Tracks, New Releases
  private func fetchData() {
    let group = DispatchGroup()
    
    group.enter()
    group.enter()
    group.enter()
    
    var newReleases: NewReleasesResponse?
    var featuredPlaylist: FeaturedPlaylistsResponse?
    var recommendations: RecommendationsResponse?
    
    // MARK: - New Releases
    ApiCaller.shared.getNewReleases { result in
      defer {
        group.leave()
      }
      switch result {
      case .success(let model):
        newReleases = model
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
    
    // MARK: - Featured Playlists
    ApiCaller.shared.getFeaturedPlaylists { result in
      defer {
        group.leave()
      }
      switch result {
      case .success(let model):
        featuredPlaylist = model
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
    
    
    // MARK: - Recommended Tracks
    ApiCaller.shared.getRecommendedGenres { result in
      switch result {
      case .success(let model):
        let genres = model.genres
        var seeds = Set<String>()
        while seeds.count < 5 {
          if let random = genres.randomElement() {
            seeds.insert(random)
          }
        }
        ApiCaller.shared.getRecommendations(genres: seeds) { recomResult in
          defer {
            group.leave()
          }
          switch recomResult {
          case .success(let model):
            recommendations = model
          case .failure(let err):
            print(err.localizedDescription)
          }
        }
      case .failure(_): break
      }
    }
    
    group.notify(queue: .main) {
      guard let newAlbums = newReleases?.albums.items,
            let playlists = featuredPlaylist?.playlists.items,
            let tracks = recommendations?.tracks else { return }
      
      self.configureModels(album: newAlbums, playlists: playlists, tracks: tracks)
    }
  }
  
  @objc func didTapSettings() {
    let vc = SettingsViewController()
    vc.title = "Settings"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }
  
  
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let type = sections[indexPath.section]
    
    switch type {
      
    case .newReleases(let viewModels):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleaseCollectionViewCell.identifier, for: indexPath) as? NewReleaseCollectionViewCell else { return UICollectionViewCell() }
      
      let viewModel = viewModels[indexPath.row]
      cell.configure(with: viewModel)
      return cell
    case .featuredPlaylists(let viewModels):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier, for: indexPath) as? FeaturedPlaylistCollectionViewCell else { return UICollectionViewCell() }
      cell.backgroundColor = .systemBlue
      return cell
    case .recommendedTracks(let viewModels):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else { return UICollectionViewCell() }
      cell.backgroundColor = .systemOrange
      return cell
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let type = sections[section]
    
    switch type {
      
    case .newReleases(let viewModel):
      return viewModel.count
    case .featuredPlaylists(let viewModel):
      return viewModel.count
    case .recommendedTracks(let viewModel):
      return viewModel.count
    }
  }
  
  // MARK: - Configure Models
  private func configureModels(album: [NewReleasesItem], playlists: [PlaylistItem], tracks: [AudioTrack]) {
    sections.append(.newReleases(viewModel: album.compactMap {
      return NewReleasesCell(name: $0.name, artworkUrl: URL(string: $0.images.first?.url ?? ""), numberOfTracks: $0.total_tracks, artistName: $0.artists.first?.name ?? "")
    }))
    sections.append(.featuredPlaylists(viewModel: []))
    sections.append(.recommendedTracks(viewModel: []))
    collectionView.reloadData()
  }
  
  // MARK: - CreateSectionLayout
  static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    switch section {
    case 0:
      // Item
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
      
      // Group
      // Vertical group in horizontal group
      let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)), subitem: item, count: 3)
      
      let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1.0)), subitem: verticalGroup, count: 1)
      
      // Section
      let section = NSCollectionLayoutSection(group: horizontalGroup)
      section.orthogonalScrollingBehavior = .groupPaging
      return section
    case 1:
      // Item
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(200)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
      
      // Groups
      let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), subitem: item, count: 2)
      
      let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(400)), subitem: verticalGroup, count: 1)
      
      // Section
      let section = NSCollectionLayoutSection(group: horizontalGroup)
      section.orthogonalScrollingBehavior = .continuous
      return section
    case 2:
      // Item
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
      
      // Group
      let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80)), subitem: item, count: 1)
      
      // Section
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      return section
    default:
      // Item
      let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
      
      // Group
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(1.0)), subitem: item, count: 1)
      
      // Section
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .groupPaging
      return section
    }
  }
}
