//
//  NetworkServiceImpl.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import Moya

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum MovieAppNetworkService {
    case genres
    case movies(genreId: Int, page: Int)
    case movie(id: Int)
    case movieVideo(movieId: Int)
    case userReviews(movieId: Int, page: Int)
}

extension MovieAppNetworkService: TargetType {
    static let appKey = "5f50d7c26b528bb2395aa9c7fa08f4db" // secure the key in another file or configuration production implementation
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .genres:
            return "/genre/movie/list"
        case .movies(_, _):
            return "/discover/movie"
        case .movie(let id):
            return "/movie/\(id)"
        case .movieVideo(let movieId):
            return "/movie/\(movieId)/videos"
        case .userReviews(let movieId, _):
            return "/movie/\(movieId)/reviews"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "sample".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .genres, .movie(_), .movieVideo(_):
            return .requestParameters(parameters: ["api_key": AppServerConstant.appKey], encoding: URLEncoding.queryString)
        case .movies(let genreId, let page):
            return .requestParameters(
                parameters: [
                    "api_key": AppServerConstant.appKey,
                    "with_genres": "\(genreId)",
                    "page": "\(page)"
                ],
                encoding: URLEncoding(destination: .queryString))
        case .userReviews(_, let page):
            return .requestParameters(
            parameters: [
                "api_key": AppServerConstant.appKey,
                "page": "\(page)"
            ],
            encoding: URLEncoding(destination: .queryString))
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

final class NetworkServiceImpl: NetworkService {
    private let provider: MoyaProvider<MovieAppNetworkService> = MoyaProvider<MovieAppNetworkService>(
        callbackQueue: DispatchQueue.global(qos: .background)
    )
    
    func request<D: Codable>(service: MovieAppNetworkService, completion: @escaping (Result<D, MoyaError>) -> ()) {
        provider.request(service) { (result) in
            switch result {
            case .success(let response):
                let jsonDecoder: JSONDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let response = try jsonDecoder.decode(D.self, from: response.data)
                    completion(.success(response))
                } catch let error {
                    print("::error when try to serialized response \(error)")
                    completion(.failure(.objectMapping(error, response)))
                }
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
