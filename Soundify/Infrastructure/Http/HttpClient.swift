//
//  HttpClient.swift
//  Soundify
//
//  Created by Raul Max on 06/07/22.
//

import Foundation
import BubbleTask

final class HttpClient {
  private let client: BubbleTask
  private let config: BubbleTaskConfig
  
  init(with client: BubbleTask) {
    self.client = client
    self.config = HttpClient.setupConfig()
  }
}

extension HttpClient: HttpGetClient {
  func get<T>(_ T: T.Type, to endPoint: String, params: [URLQueryItem]?) async -> Response<T> where T : Decodable {
    if AuthenticationManager.shared.shouldRefreshToken {
      await RemoteAuthentication().refresh()
    }
    
    var components = URLComponents()
    
    if let params = params {
      components.queryItems = params
    }
    
    let paramsData = components.query?.data(using: .utf8)
    
    do {
      let res = try await client.post(to: endPoint, with: paramsData)
      
      guard let statusCode = res.statusCode else {
        return .failure(UnexpectedError())
      }
      
      guard let data = res.body else {
        return .failure(EmptyData())
      }
      
      switch statusCode {
      case 200...299:
        return .success(decode(T.self, data: data))
      case 400...499:
        return .failure(UnexpectedError())
      default:
        return .failure(URLError.badServerResponse as! Error)
      }
    } catch {
      return .failure(error)
    }
  }
}

extension HttpClient: HttpPostClient {
  func post<T>(_ T: T.Type, to endPoint: String, body: [String : Any]?) async -> Response<T> where T : Decodable {
    if AuthenticationManager.shared.shouldRefreshToken {
      await RemoteAuthentication().refresh()
    }
    
    let jsonBody = try? JSONSerialization.data(withJSONObject: body as Any)
    
    do {
      let res = try await client.post(to: endPoint, with: jsonBody)
      
      guard let statusCode = res.statusCode else {
        return .failure(UnexpectedError())
      }
      
      guard let data = res.body else {
        return .failure(EmptyData())
      }
      
      switch statusCode {
      case 200...299:
        return .success(decode(T.self, data: data))
      case 400...499:
        return .failure(UnexpectedError())
      default:
        return .failure(URLError.badServerResponse as! Error)
      }
    } catch {
      return .failure(error)
    }
  }
}

// MARK: - Private

extension HttpClient {
  private func decode<T: Decodable>(_ T: T.Type, data: Data) -> T {
    let result = try! JSONDecoder().decode(T.self, from: data)
    return result
  }
  
  fileprivate class func setupConfig() -> BubbleTaskConfig {
    let headers = [
      "Authorization": "Bearer \(AuthenticationManager.shared.accessToken ?? "")"
    ]
    return BubbleTaskConfig(baseUrl: Constants.baseURL, headers: headers, timeout: 30)
  }
}
