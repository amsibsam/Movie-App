//
//  MovieRowProtocol.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol MovieRowCellWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol MovieRowCellPresenterProtocol: class {
    /* ViewController -> Presenter */
    func getMovie()
}

//MARK: View -
protocol MovieRowCellViewProtocol: class {

    var presenter: MovieRowCellPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func showMovie(movie: Movie?)
}
