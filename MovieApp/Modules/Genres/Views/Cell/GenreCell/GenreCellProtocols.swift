//
//  VGenreCellProtocols.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol GenreCellWireframeProtocol: class {
    func openMovies(withGenre genre: Genre)
    func openMovie(movie: Movie)
}
//MARK: Presenter -
protocol GenreCellPresenterProtocol: class {

    var interactor: GenreCellInteractorInputProtocol? { get set }
    
    var movies: [Movie] { get }
    
    /* ViewController -> Presenter */
    func getMovies()
    
    func getGenre()
    
    func openMovies()
    
    func openMovie(atIndex index: Int)
}

//MARK: Interactor -
protocol GenreCellInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onGetMoviesFailed(errorMessage: String)
    func onGetMoviesSucceed(movies: [Movie])
}

protocol GenreCellInteractorInputProtocol: class {

    var networkService: NetworkService? { get set }
    var presenter: GenreCellInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getMovies(withGenreId id: Int)
}

//MARK: View -
protocol GenreCellViewProtocol: class {

    var presenter: GenreCellPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func reloadTableView()
    func showLoading()
    func stopLoading()
    func showError(errorMessage: String)
    func showGenre(genre: Genre)
}
