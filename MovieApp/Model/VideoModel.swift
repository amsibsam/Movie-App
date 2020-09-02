//
//  VideoModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

struct Video: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1
        case iso3166_1
        case key, name, site, size, type
    }
}
