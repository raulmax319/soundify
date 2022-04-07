//
//  FeaturedPlaylistCollectionViewCell.swift
//  Soundify
//
//  Created by Raul Max on 14/01/22.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
  static let identifier = "FeaturedPlaylistCollectionViewCell"
  
  private let playlistCoverImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.image = UIImage(systemName: "photo")
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  private let playlistNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .semibold)
    return label
  }()
  
  private let creatorNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 16, weight: .regular)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.clipsToBounds = true
    contentView.addSubview(playlistCoverImageView)
    contentView.addSubview(playlistNameLabel)
    contentView.addSubview(creatorNameLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    creatorNameLabel.frame = CGRect(x: 3, y: contentView.height - 60, width: contentView.width - 6, height: 60)
    playlistNameLabel.frame = CGRect(x: 3, y: contentView.height - 88, width: contentView.width - 6, height: 60)
    let imageSize = contentView.height - 90
    playlistCoverImageView.frame = CGRect(x: (contentView.width-imageSize) / 2, y: 3, width: imageSize, height: imageSize)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    playlistNameLabel.text = nil
    creatorNameLabel.text = nil
    playlistCoverImageView.image = nil
  }
  
  func configure(with viewModel: FeaturedPlaylistCell) {
    playlistNameLabel.text = viewModel.name
    creatorNameLabel.text = viewModel.creatorName
    playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
  }
}
