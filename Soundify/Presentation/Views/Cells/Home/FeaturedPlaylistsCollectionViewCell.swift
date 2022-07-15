//
//  FeaturedPlaylistsCollectionViewCell.swift
//  Soundify
//
//  Created by Raul Max on 12/07/22.
//

import UIKit

class FeaturedPlaylistsCollectionViewCell: UICollectionViewCell {
  static let kReuseIdentifier = "FeaturedPlaylistsCollectionViewCell"
  
  private lazy var playlistCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private lazy var playlistNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 1
    label.font = UIFont.bold(ofSize: 16)
    label.lineBreakMode = .byTruncatingTail
    label.textColor = .secondaryLabel
    
    return label
  }()
  
  private lazy var creatorNameLabel: UILabel = {
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
    
    playlistNameLabel.text = nil
    creatorNameLabel.text = nil
    playlistCoverImageView.image = nil
  }
}

// MARK: - Private
extension FeaturedPlaylistsCollectionViewCell {
  private func configureSubViews() {
    contentView.clipsToBounds = true
    contentView.addSubview(playlistCoverImageView)
    contentView.addSubview(playlistNameLabel)
    contentView.addSubview(creatorNameLabel)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      playlistCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      playlistCoverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      playlistCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      playlistCoverImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
      playlistCoverImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
      playlistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      playlistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      playlistNameLabel.topAnchor.constraint(equalTo: playlistCoverImageView.bottomAnchor, constant: 10),
      creatorNameLabel.leadingAnchor.constraint(equalTo: playlistNameLabel.leadingAnchor),
      creatorNameLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor),
    ])
  }
}

// MARK: - Public
extension FeaturedPlaylistsCollectionViewCell {
  public func configure(with viewData: FeaturedPlaylistsViewData) {
    playlistNameLabel.text = viewData.name
    creatorNameLabel.text = viewData.creatorName
    playlistCoverImageView.sd_setImage(with: viewData.artworkUrl)
  }
}
