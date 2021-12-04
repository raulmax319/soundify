//
//  APICaller.swift
//  Soundify
//
//  Created by Raul Max on 02/12/21.
//

import Foundation

final class ApiCaller {
  static let shared = ApiCaller()
  
  private init() {}
  
  struct Constants {
    static let baseURL = readPlist(key: "baseURLV1")
  }
  
  enum APIError: Error {
    case failedToGetData
  }
  
  public func getCurrentUserProfile(completion: @escaping (Result<User, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/me"), type: .GET, completion: { request in
      let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }

        do {
          let response = try JSONDecoder().decode(User.self, from: data)
          print(response)
        } catch {
          completion(.failure(error))
        }
      })
      task.resume()
    })
  }
  
  // MARK: - Private
  
  enum HTTPMethod: String {
    case GET
    case POST
  }

  private func makeRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
    AuthManager.shared.withValidToken(completion: { token in
      guard let apiURL = url else { return }
      var request = URLRequest(url: apiURL)
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      request.httpMethod = type.rawValue
      request.timeoutInterval = 30
      completion(request)
    })
  }
}
