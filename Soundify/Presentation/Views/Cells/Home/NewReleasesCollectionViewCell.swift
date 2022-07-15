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
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private lazy var albumNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.regular(ofSize: 16)
    label.lineBreakMode = .byTruncatingTail
    
    return label
  }()
  
  private lazy var albumTypeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = UIFont.regular(ofSize: 14)
    label.textColor = .secondaryLabel
    
    return label
  }()
  
  private lazy var artistNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont.regular(ofSize: 14)
    label.textColor = .secondaryLabel
    
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
    albumTypeLabel.text = nil
    albumCoverImage.image = nil
  }
}

// MARK: - Private
extension NewReleasesCollectionViewCell {
  private func configureSubViews() {
    contentView.clipsToBounds = true
    contentView.addSubview(albumCoverImage)
    contentView.addSubview(albumNameLabel)
    contentView.addSubview(albumTypeLabel)
    contentView.addSubview(artistNameLabel)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      albumCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      albumCoverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      albumCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      albumCoverImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      albumCoverImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
      albumNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      albumNameLabel.topAnchor.constraint(equalTo: albumCoverImage.bottomAnchor, constant: 10),
      albumTypeLabel.leadingAnchor.constraint(equalTo: albumNameLabel.leadingAnchor),
      albumTypeLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
      artistNameLabel.leadingAnchor.constraint(equalTo: albumTypeLabel.trailingAnchor),
      artistNameLabel.centerYAnchor.constraint(equalTo: albumTypeLabel.centerYAnchor)
    ])
  }
}

// MARK: - Public
extension NewReleasesCollectionViewCell {
  public func configure(with viewData: NewReleasesViewData) {
    albumNameLabel.text = viewData.name
    artistNameLabel.text = viewData.artistName
    albumTypeLabel.text = "\(viewData.albumType.capitalized) • "
    albumCoverImage.sd_setImage(with: viewData.artworkUrl)
  }
}
