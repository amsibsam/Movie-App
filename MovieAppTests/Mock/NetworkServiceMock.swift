//
//  NetworkServiceMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import Moya

class NetworkServiceMock: NetworkService {
    var isSuccess: Bool = true
    var successResponse: Codable?
    var errorResponse: MoyaError?

    func request<D: Codable>(service: MovieAppNetworkService, completion: @escaping (Result<D, MoyaError>) -> ()) {
        if isSuccess {
            completion(.success(successResponse as! D))
        } else {
            completion(.failure(errorResponse!))
        }
    }
    
}
