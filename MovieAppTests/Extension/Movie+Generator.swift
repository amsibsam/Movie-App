//
//  Movie+Generator.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

extension Movie {
    static func generateDummyMovie() -> Movie {
        return Movie(popularity: 0, voteCount: 0, video: false, posterPath: nil, id: 1, adult: false, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: "dummy", voteAverage: nil, overview: "overview", releaseDate: nil, status: nil)
    }
    
    static func generateDummyMovieWithPoster() -> Movie {
        return Movie(popularity: 0, voteCount: 0, video: false, posterPath: "poster/path", id: 1, adult: false, backdropPath: nil, originalLanguage: nil, originalTitle: nil, genreIDS: nil, title: "dummy", voteAverage: nil, overview: "overview", releaseDate: nil, status: nil)
    }
}
