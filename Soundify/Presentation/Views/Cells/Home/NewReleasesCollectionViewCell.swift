//
//  NewReleasesCollectionViewCell.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit
import SDWebImage

class NewReleasesCollectionViewCell: UICollectionViewCell {
  static let kReuseIdentifier = "NewReleasesCollectionViewCell"
  
  private lazy var albumCoverImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "photo")
    imageView.clipsToBounds = true
    
    return imageView
  }()
  
  private lazy var albumNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = .regular(ofSize: 18)
    
    return label
  }()
  
  private lazy var artistNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .medium(ofSize: 16)
    
    return label
  }()
  
  private lazy var numberOfTracksLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .regular(ofSize: 16)
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureSubViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    configureConstraints()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    albumNameLabel.text = nil
    artistNameLabel.text = nil
    numberOfTracksLabel.text = nil
    albumCoverImage.image = nil
  }
  
  public func configure(with viewData: NewReleasesViewData) {
    albumNameLabel.text = viewData.name
    artistNameLabel.text = viewData.artistName
    numberOfTracksLabel.text = "Tracks: \(viewData.numberOfTracks)"
    albumCoverImage.sd_setImage(with: viewData.artworkUrl)
  }
}

// MARK: - Private
extension NewReleasesCollectionViewCell {
  private func configureSubViews() {
    contentView.clipsToBounds = true
    contentView.backgroundColor = .secondarySystemBackground
    contentView.addSubview(albumNameLabel)
    contentView.addSubview(albumCoverImage)
    contentView.addSubview(numberOfTracksLabel)
    contentView.addSubview(artistNameLabel)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      albumCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      albumCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      albumCoverImage.widthAnchor.constraint(equalTo: contentView.heightAnchor),
      albumCoverImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
      albumNameLabel.leadingAnchor.constraint(equalTo: albumCoverImage.trailingAnchor, constant: 5),
      albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      albumNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
      artistNameLabel.leadingAnchor.constraint(equalTo: albumNameLabel.leadingAnchor),
      artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
      numberOfTracksLabel.leadingAnchor.constraint(equalTo: albumNameLabel.leadingAnchor),
      numberOfTracksLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
    ])
  }
}
