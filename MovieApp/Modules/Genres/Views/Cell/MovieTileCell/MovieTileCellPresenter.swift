//
//  MovieTilePresenter.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class MovieTileCellPresenter: MovieTileCellPresenterProtocol {
    private var movie: Movie?
    weak private var view: MovieTileCellViewProtocol?
    
    init(movie: Movie?, interface: MovieTileCellViewProtocol) {
        self.movie = movie
        self.view = interface
    }
    
    func getMovie() {
        guard let movie = self.movie else {
            return
        }
        
        Thread.runOnMainThread { [weak self] in
            self?.view?.showMovie(movie: movie)
        }
    }
}
