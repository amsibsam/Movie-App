//
//  NetworkService.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

protocol NetworkService {
    init(urlSessionService: URLSessionService)
    
    func request<D: Codable>(url: URL, method: HTTPMethod, query: [String: String]?, requestBody: [String: Any]?, completion: @escaping (Result<D, ApiErrorModel>) -> ())
}
