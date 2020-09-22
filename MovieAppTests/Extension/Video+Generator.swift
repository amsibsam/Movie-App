//
//  Video+Generator.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

extension Video {
    static func generateDummyVideo() -> Video {
        return Video(id: "1", iso639_1: nil, iso3166_1: nil, key: "dummy key", name: nil, site: "YouTube", size: nil, type: "Trailer")
    }
    
    static func generateDummyVideoNonYoutube() -> Video {
        return Video(id: "1", iso639_1: nil, iso3166_1: nil, key: "dummy key", name: nil, site: "NonYoutube", size: nil, type: "Trailer")
    }
}
