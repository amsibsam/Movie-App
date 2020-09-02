//
//  DiscoveryResponse.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

struct DiscoveryResponse: Codable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults
        case totalPages
        case results
    }
}
