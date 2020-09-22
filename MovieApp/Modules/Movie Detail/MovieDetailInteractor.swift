//
//  VMovieDetailInteractor.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import Moya

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    var networkService: NetworkService? = NetworkServiceImpl()
    weak var presenter: MovieDetailInteractorOutputProtocol?
    
    func getUserReviews(on movieId: Int, page: Int) {
        networkService?.request(service: .userReviews(movieId: movieId, page: page)) { [weak self] (result: Result<UserReviewResponse, MoyaError>) in
            switch result {
            case .failure(let error):
                self?.presenter?.onGetUserReviewFailed(errorMessage: error.localizedDescription)
            case .success(let userReviewResponse):
                self?.presenter?.onGetUserReviewsSucceed(userReviews: userReviewResponse.results)
            }
        }
    }
}
