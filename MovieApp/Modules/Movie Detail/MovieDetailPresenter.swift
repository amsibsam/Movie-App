//
//  VMovieDetailPresenter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol, MovieDetailInteractorOutputProtocol {
    
    var interactor: MovieDetailInteractorInputProtocol?
    weak private var view: MovieDetailViewProtocol?
    private let router: MovieDetailWireframeProtocol
    private var _userReviews: [UserReview] = []
    private let _movie: Movie

    var userReviews: [UserReview] {
        get {
            return _userReviews
        }
    }
    
    var movie: Movie {
        get {
            return  _movie
        }
    }
    
    private var page: Int = 1
    
    required init(movie: Movie, interface: MovieDetailViewProtocol, router: MovieDetailWireframeProtocol, interactor: MovieDetailInteractorInputProtocol) {
        self.view = interface
        self.router = router
        self._movie = movie
        self.interactor = interactor
    }

    func getMoviePoster() {
        guard let posterMedium = _movie.posterMedium else {
            return
        }
        view?.showMoviePoster(moviePosterUrl: posterMedium)
    }
    
    func getUserReview() {
        interactor?.getUserReviews(on: _movie.id, page: self.page)
    }
    
    // MARK: Interactor delegate
    func onGetUserReviewsSucceed(userReviews: [UserReview]) {
        if userReviews.isEmpty {
            return
        }
        
        if self.page == 1 {
            _userReviews = userReviews
        } else {
            _userReviews.append(contentsOf: userReviews)
        }
        
        self.page += 1
        Thread.runOnMainThread { [weak self] in
            self?.view?.refreshTableView()
        }
    }
    
    func onGetUserReviewFailed(errorMessage: String) {
        print("error get movie detail updated data \(errorMessage)")
    }
}
