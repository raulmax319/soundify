//
//  HomeView.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import UIKit

enum BrowseSectionType {
  case newReleases(viewModel: [NewReleasesViewData])
  case featuredPlaylists(viewModel: [FeaturedPlaylistsViewData])
  case recommendedTracks(viewModel: [RecommendedTracksViewData])
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
  
  /// this var is used to carry the data when navigating
  /// to the Recommended Album
  private var albums: [AlbumModel] = []
  /// this var is used to carry the data when navigating
  /// to the Recommended Playlist Screen
  private var playlists: [PlaylistItemModel] = []
  /// this var is used to carry the data when navigating
  /// to the Recommended Tracks Screen
  private var tracks: [AudioTrackModel] = []
  
  /// Sections of the Home View
  private var sections = [BrowseSectionType]()
  weak var delegate: HomeSharedDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private
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
  
  @MainActor private func configureModels(
    album: [AlbumModel],
    playlists: [PlaylistItemModel],
    tracks: [AudioTrackModel]
  ) {
    sections.append(.newReleases(viewModel: album.compactMap {
      return NewReleasesViewData(
        name: $0.name,
        artworkUrl: URL(string: $0.images.first?.url ?? ""),
        albumType: $0.albumType.rawValue,
        artistName: $0.artists.first?.name ?? ""
      )
    }))
    sections.append(.featuredPlaylists(viewModel: playlists.compactMap {
      return FeaturedPlaylistsViewData(
        name: $0.name,
        artworkUrl: URL(string: $0.images.first?.url ?? ""),
        creatorName: $0.owner.displayName
      )
    }))
    sections.append(.recommendedTracks(viewModel: tracks.compactMap {
      return RecommendedTracksViewData(
        name: $0.name,
        artistName: $0.artists.first?.name ?? "",
        artworkUrl: URL(string: $0.album?.images.first?.url ?? "")
      )
    }))
    collectionView.reloadData()
  }
}

// MARK: - Public
extension HomeView {
  public func configureGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.startPoint = .zero
    gradientLayer.endPoint = CGPoint(x: 0.45, y: 1)
    gradientLayer.colors = [
      UIColor(red: CGFloat.random(in: 0...255) / 255, green: CGFloat.random(in: 0...255) / 255, blue: CGFloat.random(in: 0...255) / 255, alpha: 1).cgColor,
      UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1).cgColor,
    ]
    
    self.layer.insertSublayer(gradientLayer, at: 0)
    gradientLayer.frame = self.bounds
  }
  
  public func fetchData() {
    var newReleases: NewReleasesModel?
    var featuredPlaylists: FeaturedPlaylistsModel?
    var recommendations: RecommendationsModel?
    
    let newReleasesViewModel = NewReleasesViewModel()
    let featuredPlaylistsViewModel = FeaturedPlaylistsViewModel()
    let recommendationsViewModel = RecommendationsViewModel()
    
    // TODO: - Run tasks in parallel
    Task {
      await newReleasesViewModel.load()
      await featuredPlaylistsViewModel.load()
      await recommendationsViewModel.load()
      
      if let newReleasesModel = await newReleasesViewModel.model,
         let featuredPlaylistsModel = await featuredPlaylistsViewModel.model,
         let recommendationsModel = await recommendationsViewModel.model {
        newReleases = newReleasesModel
        featuredPlaylists = featuredPlaylistsModel
        recommendations = recommendationsModel
      }
      
      guard let albums = newReleases?.albums.items,
            let playlists = featuredPlaylists?.playlists.items,
            let tracks = recommendations?.tracks
      else {
        return
      }
      
      await MainActor.run {
        self.albums = albums
        self.playlists = playlists
        self.tracks = tracks
        self.configureModels(album: albums, playlists: playlists, tracks: tracks)
      }
    } // Task
  }
}

extension HomeView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    
    switch sections[indexPath.section] {
    case .featuredPlaylists:
      delegate?.navigateToPlaylistScreen(playlist: playlists[indexPath.row])
      break
    case .newReleases:
      delegate?.navigateToAlbumScreen(album: albums[indexPath.row])
      break
    case .recommendedTracks:
      delegate?.navigateToRecommendationsScreen(track: tracks[indexPath.row])
      break
    }
  }
}

// MARK: - CollectionView Datasource
extension HomeView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch sections[section] {
    case .newReleases(viewModel: let vm):
      return vm.count
    case .featuredPlaylists(viewModel: let vm):
      return vm.count
    case .recommendedTracks(viewModel: let vm):
      return vm.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch sections[indexPath.section] {
    /// New Releases View Data Supplier
    case .newReleases(viewModel: let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: NewReleasesCollectionViewCell.kReuseIdentifier,
        for: indexPath
      ) as? NewReleasesCollectionViewCell else { return UICollectionViewCell() }
      cell.configure(with: viewModel[indexPath.row])
      return cell
    
    /// Featured Playlists View Data Supplier
    case .featuredPlaylists(viewModel: let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.kReuseIdentifier,
        for: indexPath
      ) as? FeaturedPlaylistsCollectionViewCell else { return UICollectionViewCell() }
      cell.configure(with: viewModel[indexPath.row])
      return cell
    
      /// Recommended Tracks View Data Supplier
    case .recommendedTracks(viewModel: let viewModel):
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: RecommendedTracksCollectionViewCell.kReuseIdentifier,
        for: indexPath
      ) as? RecommendedTracksCollectionViewCell else { return UICollectionViewCell() }
      cell.configure(with: viewModel[indexPath.row])
      return cell
    }
  }
}

// MARK: - Collection Layout Sections
extension HomeView {
  static func createSectionLayout(for section: Int) -> NSCollectionLayoutSection {
    switch section {
    case 0:
      return NewReleasesCollectionLayoutSection()
    case 1:
      return FeaturedPlaylistsCollectionLayoutSection()
    case 2:
      return RecommendationsCollectionLayoutSection()
    default:
      // This case doesnt actually happen but switch must be exhaustive
      return FeaturedPlaylistsCollectionLayoutSection()
    }
  }
}
