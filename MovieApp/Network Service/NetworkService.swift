//
//  NetworkService.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import Moya

protocol NetworkService {
    func request<D: Codable>(service: MovieAppNetworkService, completion: @escaping (Result<D, MoyaError>) -> ())
}
