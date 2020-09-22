//
//  MovieRowCellPresenter.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

class MovieRowCellPresenter: MovieRowCellPresenterProtocol {
    private let movie: Movie?
    private let router: MovieRowCellWireframeProtocol
    weak private var view: MovieRowCellViewProtocol?
    
    init(movie: Movie?, interface: MovieRowCellViewProtocol, router: MovieRowCellWireframeProtocol) {
        self.movie = movie
        self.view = interface
        self.router = router
    }
    
    func getMovie() {
        Thread.runOnMainThread { [weak self] in
            guard let self = self else {
                return
            }
            
            self.view?.showMovie(movie: self.movie)
        }
    }
}
