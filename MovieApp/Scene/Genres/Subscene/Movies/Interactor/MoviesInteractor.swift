//
//  MoviesInteractor.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

protocol MoviesInteractor {
    
    var networkService: NetworkService { get }
    
    init(networkService: NetworkService)
    
    func getMovies(withGenreId id: Int, page: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void)
}
