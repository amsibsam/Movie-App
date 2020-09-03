//
//  MoviesInteractorMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class MoviesInteractorMock: MoviesInteractor {
    
    var networkService: NetworkService
    var isSuccess: Bool = true
    var movies: [Movie] = []
    
    required init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getMovies(withGenreId id: Int, page: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        if isSuccess {
            onSuccess(movies)
        } else {
            onError("")
        }
    }
    
    func reset() {
        isSuccess = true
    }
}
