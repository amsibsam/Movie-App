//
//  VGenresInteractor.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import Moya

class GenresInteractor: GenresInteractorInputProtocol {
    
    var networkService: NetworkService? = NetworkServiceImpl()

    weak var presenter: GenresInteractorOutputProtocol?
    
    func getGenres() {
        networkService?.request(service: MovieAppNetworkService.genres, completion: { [weak self] (result: Result<GenreResponse, MoyaError>) in
            switch result {
            case .failure(let error):
                self?.presenter?.onGetGenresFailed(errorMessage: error.localizedDescription)
            case .success(let genreResponse):
                self?.presenter?.onGetGenresSucceed(genres: genreResponse.genres)
            }
        })
    }
}
