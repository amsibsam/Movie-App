//
//  MoviesNavigatorMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class MoviesNavigatorMock: MoviesNavigator {
    
    var isOpenMovieDetailCalled = false
    
    func openMovieDetail(with movie: Movie) {
        isOpenMovieDetailCalled = true
    }
    
    func reset() {
        isOpenMovieDetailCalled = false
    }
}
