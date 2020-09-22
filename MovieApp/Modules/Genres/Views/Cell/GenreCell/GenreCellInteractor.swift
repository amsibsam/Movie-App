//
//  VGenreCellInteractor.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import Moya

class GenreCellInteractor: GenreCellInteractorInputProtocol {

    weak var presenter: GenreCellInteractorOutputProtocol?
    
    var networkService: NetworkService? = NetworkServiceImpl()
    
    func getMovies(withGenreId id: Int) {
        networkService?.request(service: MovieAppNetworkService.movies(genreId: id, page: 1), completion: { [weak self] (result: Result<DiscoveryResponse, MoyaError>) in
            switch result {
            case .failure(let error):
                self?.presenter?.onGetMoviesFailed(errorMessage: error.localizedDescription)
            case .success(let discoveryResponse):
                self?.presenter?.onGetMoviesSucceed(movies: discoveryResponse.results ?? [])
            }
        })
    }
    
}
