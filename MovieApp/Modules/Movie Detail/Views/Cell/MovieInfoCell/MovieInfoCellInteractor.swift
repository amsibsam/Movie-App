//
//  MovieInfoCellInteractor.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import Moya

class MovieInfoCellInteractor: MovieInfoCellInteractorInputProtocol {
    var networkService: NetworkService? = NetworkServiceImpl()
    
    weak var presenter: MovieInfoCellInteractorOutputProtocol?
    
    func getMovie(withId id: Int) {
        networkService?.request(service: .movie(id: id)) { [weak self] (result: Result<Movie, MoyaError>) in
            switch result {
            case .failure(let error):
                self?.presenter?.onGetMovieFailed(errorMessage: error.localizedDescription)
            case .success(let movie):
                self?.presenter?.onGetMovieSucceed(movie: movie)
            }
        }
    }
    
}
