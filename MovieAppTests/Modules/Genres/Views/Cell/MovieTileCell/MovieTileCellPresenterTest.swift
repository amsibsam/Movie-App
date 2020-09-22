//
//  MovieTileCellPresenter.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieTileCellPresenterTest: XCTestCase {
    
    var sutPresenter: MovieTileCellPresenter?
    var movieMock: Movie = Movie.generateDummyMovie()
    var movieTileCellViewMock: MovieTileCellViewMock?
    
    override func setUp() {
        movieTileCellViewMock = MovieTileCellViewMock()
        sutPresenter = MovieTileCellPresenter(movie: movieMock, interface: movieTileCellViewMock!)
        movieTileCellViewMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        movieTileCellViewMock = nil
        super.tearDown()
    }

    func testGetMovie() {
        sutPresenter?.getMovie()
        XCTAssertTrue(movieTileCellViewMock!.isShowMovieCalled)
    }
    
    func testGetMovieNil() {
        sutPresenter = MovieTileCellPresenter(movie: nil, interface: movieTileCellViewMock!)
        sutPresenter?.getMovie()
        XCTAssertFalse(movieTileCellViewMock!.isShowMovieCalled)
    }
}

class MovieTileCellViewMock: MovieTileCellViewProtocol {
    var presenter: MovieTileCellPresenterProtocol?
    var isShowMovieCalled: Bool = false
    
    func showMovie(movie: Movie) {
        isShowMovieCalled = true
    }
}
