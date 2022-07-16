//
//  SectionHeader.swift
//  Soundify
//
//  Created by Raul Max on 16/07/22.
//

import Foundation
import UIKit

class SectionHeader: UICollectionReusableView {
  static let kReuseIdentifier = "SectionHeader"
  
  lazy var title: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.bold(ofSize: 25)
    label.sizeToFit()
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(title)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      title.trailingAnchor.constraint(equalTo: trailingAnchor),
      title.topAnchor.constraint(equalTo: topAnchor),
    ])
  }
}

extension SectionHeader {
  public func configure(title: String) {
    self.title.text = title
  }
}
