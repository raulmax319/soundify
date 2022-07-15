//
//  Configuration.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation

enum Environment: String {
  case develop
  case production
  
  static let current: Environment = {
    guard let rawValue = Bundle.main.infoDictionary?["ENV"] as? String else {
      fatalError("No configuration Found.")
    }
    
    guard let config = Environment(rawValue: rawValue.lowercased()) else {
      fatalError("Invalid Configuration")
    }
    
    return config
  }()
}

extension Environment {
  static var baseURL: URL {
    switch current {
    case .develop: return URL(string: readConfig["BASE_URL"]!)!
    case .production: return URL(string: "")!
    }
  }
}

extension Environment {
  static let readConfig: Dictionary<String, String> = {
    return (Bundle.main.infoDictionary!["HTTP_URLS"] as? Dictionary<String, String>)!
  }()
}
