//
//  NetworkServiceImpl.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final class NetworkServiceImpl: NetworkService {
    func request<D>(url: URL, method: HTTPMethod, query: [String : String]?, requestBody: [String: Any]?, completion: @escaping (Result<D, ApiErrorModel>) -> ()) where D : Codable {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: AppServerConstant.appKey)]
        if let query = query {
            queryItems.append(contentsOf: query.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let urlSession = URLSession.shared
        
        var urlRequest = URLRequest(url: finalURL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        urlRequest.httpMethod = method.rawValue
        
        if let requestBody = requestBody {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            } catch let error {
                print("::error when try to serialized response \(error)")
                completion(.failure(.invalidEndpoint))
            }
        }
        
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments)
                print("response \(json)")
            } catch {
                
            }
            
            guard error == nil else {
                completion(.failure(.apiError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            let jsonDecoder: JSONDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                
                let response = try jsonDecoder.decode(D.self, from: data)
                completion(.success(response))
            } catch let error {
                print("::error when try to serialized response \(error)")
                completion(.failure(.serializationError))
            }
            
        }.resume()
        
    }
}
