//
//  GenresInteractorMock.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class GenresInteractorMock: GenresInteractor {
    var networkService: NetworkService
    var isSuccess: Bool = true
    
    required init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getGenres(onSuccess: @escaping ([Genre]) -> Void, onError: @escaping (String) -> Void) {
        if isSuccess {
            onSuccess([])
        } else {
            onError("")
        }
    }
    
    func getMovies(withGenreId id: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        if isSuccess {
            onSuccess([])
        } else {
            onError("")
        }
    }
    
    func reset() {
        isSuccess = true
    }
}
