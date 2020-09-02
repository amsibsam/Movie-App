//
//  AppContant.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

final class AppServerConstant {
    static let appKey = "5f50d7c26b528bb2395aa9c7fa08f4db"
    static let baseUrl = "https://api.themoviedb.org/3"
    static let genres = "\(AppServerConstant.baseUrl)/genre/movie/list"
    static let movies = "\(AppServerConstant.baseUrl)/discover/movie"
    static func movie(movieId: Int) -> String {
        "\(AppServerConstant.baseUrl)/movie/\(movieId)"
    }
    static func movieVideo(movieId: Int) -> String {
        "\(AppServerConstant.baseUrl)/movie/\(movieId)/videos"
    }
    static func userReviews(movieId: Int) -> String {
        "\(AppServerConstant.baseUrl)/movie/\(movieId)/reviews"
    }
    
}
