//
//  VMoviesProtocols.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol MoviesWireframeProtocol: class {
    func openMovieDetail(movie: Movie)
    func showError(errorMessage: String)
}
//MARK: Presenter -
protocol MoviesPresenterProtocol: class {

    var interactor: MoviesInteractorInputProtocol? { get set }
    var movies: [Movie] { get }
    
    /* ViewController -> Presenter */
    func getMovies()
    func getTitle()
    func openMovieDetail(atIndex index: Int)
}

//MARK: Interactor -
protocol MoviesInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onGetMoviesSucceed(movies: [Movie])
    func onGetMoviesFailed(errorMessage: String)
}

protocol MoviesInteractorInputProtocol: class {

    var networkService: NetworkService? { get set }
    var presenter: MoviesInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getMovies(withGenreId id: Int, page: Int)
}

//MARK: View -
protocol MoviesViewProtocol: class {

    var presenter: MoviesPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func reloadTableView()
    func showTitle(title: String)
    func showLoading()
    func stopLoading()
}
