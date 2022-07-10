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
  
  static let authURL: String = {
    guard let urls = Bundle.main.infoDictionary?["HTTP_URLS"] as? NSDictionary else {
      fatalError("HTTP_URLS/AUTH_URL Not found in Info plist")
    }
    
    return urls.object(forKey: "AUTH_URL") as! String
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
  
  static let redirectURL: String = {
    guard let url = Bundle.main.infoDictionary?["HTTP_URLS"] as? NSDictionary else {
      fatalError("HTTP_URLS/REDIRECT_URL Not found in Info plist")
    }
    
    return url.object(forKey: "REDIRECT_URL") as! String
  }()
  
  static let scopes: [String] = {
    guard let scopes = Bundle.main.infoDictionary?["SCOPES"] as? [String] else {
      fatalError("SCOPES Not found in Info plist")
    }
    
    return scopes
  }()
}
