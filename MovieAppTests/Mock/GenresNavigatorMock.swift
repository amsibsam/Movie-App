//
//  GenresNavigatorMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class GenresNavigatorMock: GenresNavigator {
    var isOpenMoviesCalled = false
    var isOpenMovieCalled = false
    
    func openMovies(withGenre genre: Genre) {
        isOpenMoviesCalled = true
    }
    
    func openMovie(_ movie: Movie) {
        isOpenMovieCalled = true
    }
    
    func reset() {
        isOpenMovieCalled = false
        isOpenMoviesCalled = false
    }
}
