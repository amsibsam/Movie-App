//
//  URLSessionServiceMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class URLSessionServiceMock: URLSessionService {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
    }
}
