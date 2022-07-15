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
    imageView.clipsToBounds = true
    
    return imageView
  }()
  
  private lazy var trackNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = .bold(ofSize: 18)
    
    return label
  }()
  
  private lazy var artistNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = .bold(ofSize: 18)
    
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
    
    albumCoverImage.image = nil
    trackNameLabel.text = nil
    artistNameLabel.text = nil
  }
  
  public func configure(with viewData: RecommendedTracksViewData) {
    trackNameLabel.text = viewData.name
    artistNameLabel.text = viewData.artistName
    albumCoverImage.sd_setImage(with: viewData.artworkUrl)
  }
}

// MARK: - Private
extension RecommendedTracksCollectionViewCell {
  private func configureSubViews() {
    contentView.clipsToBounds = true
    contentView.backgroundColor = .secondarySystemBackground
    contentView.addSubview(albumCoverImage)
    contentView.addSubview(trackNameLabel)
    contentView.addSubview(artistNameLabel)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint.activate([
      
    ])
  }
}
