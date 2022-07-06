//
//  Constants.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

struct Constants {
  static let clientID: String = {
    guard let clientId = Bundle.main.infoDictionary?["CLIENT_ID"] as? String else {
      fatalError("CLIENT_ID Not found in Info plist")
    }
    
    return clientId
  }()
  
  static let clientSecret: String = {
    guard let clientSecret = Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String else {
      fatalError("CLIENT_SECRET Not found in Info plist")
    }
    
    return clientSecret
  }()
  
  static let redirectURL: URL = {
    guard let uri = Bundle.main.infoDictionary?["REDIRECT_URL"] as? String,
          let url = URL(string: "https://\(uri)") else {
      fatalError("REDIRECT_URL Not found in Info plist")
    }
    
    return url
  }()
}
