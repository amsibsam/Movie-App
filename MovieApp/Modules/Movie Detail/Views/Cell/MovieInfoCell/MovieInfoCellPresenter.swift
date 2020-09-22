//
//  MovieInfoCellPresenter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MovieInfoCellPresenter: MovieInfoCellPresenterProtocol, MovieInfoCellInteractorOutputProtocol {

    weak private var view: MovieInfoCellViewProtocol?
    var interactor: MovieInfoCellInteractorInputProtocol?
    private let router: MovieInfoCellWireframeProtocol
    private let movie: Movie?

    init(movie: Movie?, interface: MovieInfoCellViewProtocol, interactor: MovieInfoCellInteractorInputProtocol?, router: MovieInfoCellWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }

    func getMovie() {
        guard let movie = self.movie else {
            return
        }
        
        view?.showMovie(movie: movie)
        interactor?.getMovie(withId: movie.id)
    }
    
    // MARK: Interactor delegate
    func onGetMovieSucceed(movie: Movie) {
        Thread.runOnMainThread { [weak self] in
            self?.view?.showMovie(movie: movie)
        }
    }
    
    func onGetMovieFailed(errorMessage: String) {
        print("error get update movie info \(errorMessage)")
    }
}
