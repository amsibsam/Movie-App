//
//  GenresInteractor.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

protocol GenresInteractor {
    var networkService: NetworkService { get }
    
    init(networkService: NetworkService)
    
    func getGenres(onSuccess: @escaping ([Genre]) -> Void, onError: @escaping (String) -> Void)
    
    func getMovies(withGenreId id: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void)
}
