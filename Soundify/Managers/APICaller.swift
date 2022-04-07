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
  
  // MARK: - Constants
  struct Constants {
    static let baseURL = readPlist(key: "baseURL")
  }
  
  enum APIError: Error {
    case failedToGetData
  }
  
  // MARK: - Albums Details
  public func getAlbumsDetails(for album: NewReleasesItem, completion: @escaping (Result<AlbumDetails, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/albums/\(album.id)"), type: .GET) {
      request in
      let task = URLSession.shared.dataTask(with: request) {
        data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let response = try JSONDecoder().decode(AlbumDetails.self, from: data)
          completion(.success(response))
        }
        catch {
          // print(error)
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Playlist Details
  public func getPlaylistsDetails(for playlist: PlaylistItem, completion: @escaping (Result<PlaylistDetails, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/playlists/\(playlist.id)"), type: .GET) {
      request in
      let task = URLSession.shared.dataTask(with: request) {
        data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let response = try JSONDecoder().decode(PlaylistDetails.self, from: data)
          completion(.success(response))
        }
        catch {
          // print(error)
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Profile
  public func getCurrentUserProfile(completion: @escaping (Result<User, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/me"), type: .GET, completion: { request in
      let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let response = try JSONDecoder().decode(User.self, from: data)
          completion(.success(response))
        } catch {
          print(error.localizedDescription)
          completion(.failure(error))
        }
      })
      task.resume()
    })
  }
  
  // MARK: - New Releases
  public func getNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/browse/new-releases?limit=50"), type: .GET) {
      request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let response = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
          completion(.success(response))
          // print(response)
        } catch {
          print(error.localizedDescription)
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Featured Playlists
  public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistsResponse, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/browse/featured-playlists?limit=50"), type: .GET) {
      request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let response = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
          completion(.success(response))
          // print(response)
        } catch {
          print(error.localizedDescription)
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  // MARK: - Recommended Tracks
  public func getRecommendations(genres: Set<String>, completion: @escaping (Result<RecommendationsResponse, Error>) -> Void) {
    let seeds = genres.joined(separator: ",")
    makeRequest(with: URL(string: "\(Constants.baseURL)/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) {
      request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          return
        }
        
        do {
          let response = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
          completion(.success(response))
          // print(response)
        } catch {
          print(error.localizedDescription)
          completion(.failure(error))
        }
      }
      task.resume()
    }
  }
  
  public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
    makeRequest(with: URL(string: "\(Constants.baseURL)/recommendations/available-genre-seeds"), type: .GET) {
      request in
      let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
          completion(.failure(APIError.failedToGetData))
          return
        }
        
        do {
          let response = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
          completion(.success(response))
          // print(response)
        } catch {
          print(error.localizedDescription)
          completion(.failure(error))
        }
      }
      task.resume()
    }
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
      print(token)
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      request.httpMethod = type.rawValue
      request.timeoutInterval = 30
      completion(request)
    })
  }
}
