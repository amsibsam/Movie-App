//
//  MovieTileProtocol.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Presenter -
protocol MovieTileCellPresenterProtocol: class {    
    /* ViewController -> Presenter */
    func getMovie()
}

//MARK: View -
protocol MovieTileCellViewProtocol: class {

    var presenter: MovieTileCellPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func showMovie(movie: Movie)
}

