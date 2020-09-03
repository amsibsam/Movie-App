//
//  MovieModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let popularity: Double
    let voteCount: Int?
    let video: Bool
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Genre]?
    let title: String
    let voteAverage: Double?
    let overview: String
    let releaseDate: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount
        case video
        case posterPath
        case id, adult
        case backdropPath
        case originalLanguage
        case originalTitle
        case genreIDS
        case title
        case voteAverage
        case overview
        case releaseDate
        case status
    }
}

extension Movie {
    var backdropSmall: URL? {
        get {
            guard let backdropPath = self.backdropPath else {
                return nil
            }
            
            return URL(string: "https://image.tmdb.org/t/p/w80/\(backdropPath)")
        }
    }
    
    var posterMedium: URL? {
        get {
            guard let posterPath = self.posterPath else {
                return nil
            }
            
            return URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)")
        }
    }
    
    var posterBig: URL? {
        get {
            guard let posterPath = self.posterPath else {
                return nil
            }
            
            return URL(string: "https://image.tmdb.org/t/p/original/\(posterPath)")
        }
    }
}
