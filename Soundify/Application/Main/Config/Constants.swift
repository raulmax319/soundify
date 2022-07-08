//
//  Constants.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

struct Constants {
  static let baseURL: String = {
    guard let urls = Bundle.main.infoDictionary?["HTTP_URLS"] as? NSDictionary else {
      fatalError("HTTP_URLS/BASE_URL Not found in Info plist")
    }
    
    return urls.object(forKey: "BASE_URL") as! String
  }()
  
  static let signInURL: String = {
    guard let urls = Bundle.main.infoDictionary?["HTTP_URLS"] as? NSDictionary else {
      fatalError("HTTP_URLS/SIGN_IN_URL Not found in Info plist")
    }
    
    return urls.object(forKey: "SIGN_IN_URL") as! String
  }()
  
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
  
  static let scopes: [String] = {
    guard let dict = Bundle.main.infoDictionary?["SCOPES"] as? NSDictionary else {
      fatalError("SCOPES Not found in Info plist")
    }
    
    let strArr = dict.object(forKey: "scopes") as! [String]
    
    return strArr
  }()
}
