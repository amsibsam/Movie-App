//
//  UserReviewModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

// MARK: - Result
struct UserReview: Codable {
    let id, author, content: String
    let url: String
}
