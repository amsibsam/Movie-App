//
//  VMovieDetailProtocols.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol MovieDetailWireframeProtocol: class {
    
}

//MARK: Presenter -
protocol MovieDetailPresenterProtocol: class {
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var userReviews: [UserReview] { get }
    var movie: Movie { get }
    
    init(movie: Movie, interface: MovieDetailViewProtocol, router: MovieDetailWireframeProtocol, interactor: MovieDetailInteractorInputProtocol)
    
    /* ViewController -> Presenter */
    func getMoviePoster()
    func getUserReview()
}


//MARK: Interactor -
protocol MovieDetailInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onGetUserReviewsSucceed(userReviews: [UserReview])
    func onGetUserReviewFailed(errorMessage: String)
}

protocol MovieDetailInteractorInputProtocol: class {

    var networkService: NetworkService? { get set }
    var presenter: MovieDetailInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getUserReviews(on movieId: Int, page: Int)
}

//MARK: View -
protocol MovieDetailViewProtocol: class {
    
    var presenter: MovieDetailPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func showMoviePoster(moviePosterUrl: URL)
    func refreshTableView()
}
