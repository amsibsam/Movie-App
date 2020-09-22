//
//  MovieInfoCellPresenterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieInfoCellPresenterTest: XCTestCase {
    var sutPresenter: MovieInfoCellPresenter?
    var mockMovie: Movie = Movie.generateDummyMovie()
    var viewMock: MovieInfoCellViewMock?
    var interactorMock: MovieInfoCellInteractorMock?
    var routerMock: MovieInfoCellRouterMock?
    
    override func setUp() {
        viewMock = MovieInfoCellViewMock()
        interactorMock = MovieInfoCellInteractorMock()
        routerMock = MovieInfoCellRouterMock()
        sutPresenter = MovieInfoCellPresenter(movie: mockMovie, interface: viewMock!, interactor: interactorMock!, router: routerMock!)
        interactorMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        interactorMock = nil
        routerMock = nil
        viewMock = nil
        super.tearDown()
    }
    
    func testGetMovieSucceed() {
        interactorMock?.isSuccess = true
        sutPresenter?.getMovie()
        XCTAssertTrue(viewMock!.isShowMovieCalled)
        XCTAssertNotEqual(mockMovie.posterPath, viewMock?.movie?.posterPath)
    }
    
    func testGetMovieFailed() {
        interactorMock?.isSuccess = false
        sutPresenter?.getMovie()
        XCTAssertTrue(viewMock!.isShowMovieCalled)
        XCTAssertEqual(mockMovie.posterPath, viewMock?.movie?.posterPath)
    }
}

class MovieInfoCellViewMock: MovieInfoCellViewProtocol {
    
    var isShowMovieCalled: Bool = false
    var movie: Movie?
    var presenter: MovieInfoCellPresenterProtocol?
    
    func showMovie(movie: Movie) {
        self.movie = movie
        isShowMovieCalled = true
    }
}

class MovieInfoCellInteractorMock: MovieInfoCellInteractorInputProtocol {
    
    
    var isSuccess: Bool = true
    var networkService: NetworkService?
    var movieResponse: Movie = Movie.generateDummyMovieWithPoster()
    var errorMessage: String = "Error"
    
    var presenter: MovieInfoCellInteractorOutputProtocol?
    
    func getMovie(withId id: Int) {
        if isSuccess {
            presenter?.onGetMovieSucceed(movie: movieResponse)
        } else {
            presenter?.onGetMovieFailed(errorMessage: errorMessage)
        }
    }
}

class MovieInfoCellRouterMock: MovieInfoCellWireframeProtocol {
    
}
