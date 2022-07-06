//
//  SignInView.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import UIKit
import WebKit

class SignInView: WKWebView {
  init() {
    let prefs = WKWebpagePreferences()
    if #available(iOS 14.0, *) {
      prefs.allowsContentJavaScript = true
    }
    
    let configuration = WKWebViewConfiguration()
    configuration.defaultWebpagePreferences = prefs
    
    super.init(frame: .zero, configuration: configuration)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
