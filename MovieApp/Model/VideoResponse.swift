//
//  VideoResponse.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

struct VideoResponse: Codable {
    let id: Int
    let results: [Video]?
}
