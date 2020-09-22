//
//  VGenreCellPresenter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class GenreCellPresenter: GenreCellPresenterProtocol, GenreCellInteractorOutputProtocol {
    
    var interactor: GenreCellInteractorInputProtocol?
    
    weak private var view: GenreCellViewProtocol?
    
    private let router: GenreCellWireframeProtocol
    
    private let genre: Genre
    
    var movies: [Movie] {
        get {
            return _movies
        }
    }
    
    private var _movies: [Movie] = []
    
    
    init(genre: Genre, interface: GenreCellViewProtocol, interactor: GenreCellInteractorInputProtocol?, router: GenreCellWireframeProtocol) {
        self.genre = genre
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    
    func getMovies() {
        view?.showLoading()
        interactor?.getMovies(withGenreId: genre.id)
    }
    
    func getGenre() {
        view?.showGenre(genre: genre)
    }
    
    func openMovie(atIndex index: Int) {
        if index >= _movies.count {
            return
        }
        
        let selectedMovie = _movies[index]
        router.openMovie(movie: selectedMovie)
    }
    
    func openMovies() {
        router.openMovies(withGenre: genre)
    }
    
    // MARK: Interactor delegate
    func onGetMoviesFailed(errorMessage: String) {
        Thread.runOnMainThread { [weak self] in
            self?.view?.stopLoading()
            self?.view?.showError(errorMessage: errorMessage)
        }
    }
    
    func onGetMoviesSucceed(movies: [Movie]) {
        _movies = movies
        Thread.runOnMainThread { [weak self] in
            self?.view?.stopLoading()
            self?.view?.reloadTableView()
        }
    }
    
}
