//
//  RecommendedTracksCollectionViewCell.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class RecommendedTracksCollectionViewCell: UICollectionViewCell {
  static let kReuseIdentifier = "RecommendedTracksCollectionViewCell"
  
  private lazy var albumCoverImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private lazy var trackNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.bold(ofSize: 16)
    label.lineBreakMode = .byTruncatingTail
    label.textColor = .secondaryLabel
    
    return label
  }()
  
  private lazy var artistNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
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
    
    trackNameLabel.text = nil
    artistNameLabel.text = nil
    albumCoverImage.image = nil
  }
}

// MARK: - Private
extension RecommendedTracksCollectionViewCell {
  private func configureSubViews() {
    contentView.clipsToBounds = true
    contentView.addSubview(albumCoverImage)
    contentView.addSubview(trackNameLabel)
    contentView.addSubview(artistNameLabel)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      albumCoverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      albumCoverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      albumCoverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
      albumCoverImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      albumCoverImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
      trackNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      trackNameLabel.topAnchor.constraint(equalTo: albumCoverImage.bottomAnchor, constant: 10),
      artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor),
    ])
  }
}

// MARK: - Public
extension RecommendedTracksCollectionViewCell {
  public func configure(with viewData: RecommendedTracksViewData) {
    trackNameLabel.text = viewData.name
    artistNameLabel.text = viewData.artistName
    albumCoverImage.sd_setImage(with: viewData.artworkUrl)
  }
}
