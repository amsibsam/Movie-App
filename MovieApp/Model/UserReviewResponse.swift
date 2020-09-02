//
//  UserReviewResponse.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

struct UserReviewResponse: Codable {
    let id, page: Int
    let results: [UserReview]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages
        case totalResults
    }
}
