//
//  NetworkServiceMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class NetworkServiceMock: NetworkService {
    var errorResponse: ApiErrorModel?
    var successResponse: Codable?
    
    required init(urlSessionService: URLSessionService = URLSessionServiceMock()) {
        
    }
    
    func request<D: Codable>(url: URL, method: HTTPMethod, query: [String: String]?, requestBody: [String: Any]?, completion: @escaping (Result<D, ApiErrorModel>) -> ()) {
        if let successResponse = self.successResponse {
            completion(.success(successResponse as! D))
            return
        }
        
        if let errorResponse = self.errorResponse {
            completion(.failure(errorResponse))
        }
    }
}
