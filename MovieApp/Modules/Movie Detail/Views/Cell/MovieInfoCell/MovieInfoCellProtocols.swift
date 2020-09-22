//
//  MovieInfoCellProtocols.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol MovieInfoCellWireframeProtocol: class {

}
//MARK: Presenter -
protocol MovieInfoCellPresenterProtocol: class {

    var interactor: MovieInfoCellInteractorInputProtocol? { get set }
    
    /* ViewController -> Presenter*/
    func getMovie()
}

//MARK: Interactor -
protocol MovieInfoCellInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onGetMovieSucceed(movie: Movie)
    func onGetMovieFailed(errorMessage: String)
}

protocol MovieInfoCellInteractorInputProtocol: class {

    var networkService: NetworkService? { get set }
    var presenter: MovieInfoCellInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getMovie(withId id: Int)
}

//MARK: View -
protocol MovieInfoCellViewProtocol: class {

    var presenter: MovieInfoCellPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func showMovie(movie: Movie)
}
