//
//  VMoviesPresenter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MoviesPresenter: MoviesPresenterProtocol, MoviesInteractorOutputProtocol {
    
    var movies: [Movie] {
        get {
            return _movies
        }
    }

    weak private var view: MoviesViewProtocol?
    var interactor: MoviesInteractorInputProtocol?
    private let router: MoviesWireframeProtocol
    private let genre: Genre
    private var _movies: [Movie] = []
    private var page: Int = 1

    init(genre: Genre, interface: MoviesViewProtocol, interactor: MoviesInteractorInputProtocol?, router: MoviesWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.genre = genre
    }
    
    func getMovies() {
        if page == 1 {
            view?.showLoading()
        }
        
        interactor?.getMovies(withGenreId: genre.id, page: page)
    }
    
    func getTitle() {
        Thread.runOnMainThread { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.showTitle(title: self.genre.name)
        }
    }
    
    func openMovieDetail(atIndex index: Int) {
        if index >= movies.count {
            return
        }
        
        router.openMovieDetail(movie: movies[index])
    }
    
    // MARK: Interactor delegate
    
    func onGetMoviesSucceed(movies: [Movie]) {
        if movies.isEmpty {
            return
        }
        
        if page == 1 {
            _movies = movies
        } else {
            _movies.append(contentsOf: movies)
        }
        page += 1
        Thread.runOnMainThread { [weak self] in
            self?.view?.stopLoading()
            self?.view?.reloadTableView()
        }
    }
    
    func onGetMoviesFailed(errorMessage: String) {
        Thread.runOnMainThread { [weak self] in
            self?.view?.stopLoading()
            self?.router.showError(errorMessage: errorMessage)
        }
    }
}
