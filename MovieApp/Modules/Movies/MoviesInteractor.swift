//
//  VMoviesInteractor.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import Moya

class MoviesInteractor: MoviesInteractorInputProtocol {
    var networkService: NetworkService? = NetworkServiceImpl()
    weak var presenter: MoviesInteractorOutputProtocol?
    
    func getMovies(withGenreId id: Int, page: Int) {
        networkService?.request(service: .movies(genreId: id, page: page)) { [weak self] (result: Result<DiscoveryResponse, MoyaError>) in
            switch result {
            case .failure(let error):
                self?.presenter?.onGetMoviesFailed(errorMessage: error.localizedDescription)
            case .success(let discoveryResponse):
                self?.presenter?.onGetMoviesSucceed(movies: discoveryResponse.results ?? [], page: page)
            }
        }
    }
    
    
}
