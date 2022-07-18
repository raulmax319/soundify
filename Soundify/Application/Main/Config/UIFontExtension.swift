//
//  UIFontExtension.swift
//  Soundify
//
//  Created by Raul Max on 10/07/22.
//

import Foundation
import UIKit

extension UIFont {
  public class func regular(ofSize size: CGFloat) -> UIFont {
    guard let customFont = UIFont(name: "CircularStd-Book", size: size) else {
      fatalError("""
        Failed to load the "CircularStd-Book" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
      )
    }
    return customFont
  }
  
  public class func medium(ofSize size: CGFloat) -> UIFont {
    guard let customFont = UIFont(name: "CircularStd-Medium", size: size) else {
      fatalError("""
        Failed to load the "CircularStd-Medium" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
      )
    }
    return customFont
  }
  
  public class func bold(ofSize size: CGFloat) -> UIFont {
    guard let customFont = UIFont(name: "CircularStd-Bold", size: size) else {
      fatalError("""
        Failed to load the "CircularStd-Bold" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
      )
    }
    return customFont
  }
  
  public class func black(ofSize size: CGFloat) -> UIFont {
    guard let customFont = UIFont(name: "CircularStd-Black", size: size) else {
      fatalError("""
        Failed to load the "CircularStd-Black" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
      )
    }
    return customFont
  }
}
