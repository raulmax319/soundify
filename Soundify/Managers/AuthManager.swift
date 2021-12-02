//
//  AuthManager.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

func readPlist(key: String) -> String {
    let path = Bundle.main.path(forResource: "Constants", ofType: "plist")
    let dict = NSDictionary(contentsOfFile: path!)
    
    let data = dict?.object(forKey: key) as! String
    
    return data
}

final class AuthManager {
    static let shared = AuthManager()
    
    
    
    struct Constants {
        static let clientID = readPlist(key: "clientID")
        static let clientSecret = readPlist(key: "clientSecret")
        static let baseURL = readPlist(key: "baseURL")
        static let scopes = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Constants", ofType: "plist")!)?.object(forKey: "scopes") as! [String]
        static let redirectURL = readPlist(key: "redirectURL")
    }
    
    private init() {}
    
    public var signInURL: URL? {
        return URL(string: "\(Constants.baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes[0])&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE")
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var expirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        // Get token
    }
    
    public func refreshAccessToken() {
        // code
    }
    
    public func cacheToken() {
        // code
    }
}
