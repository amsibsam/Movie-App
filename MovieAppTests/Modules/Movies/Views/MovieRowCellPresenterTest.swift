//
//  MovieRowCellPresenter.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieRowCellPresenterTest: XCTestCase {
    var sutPresenter: MovieRowCellPresenter?
    var movieMock: Movie = Movie.generateDummyMovie()
    var movieRowCellViewMock: MovieRowCellViewMock?
    var movieRowCellRouterMock: MovieRowCellRouterMock?
    
    override func setUp() {
        movieRowCellViewMock = MovieRowCellViewMock()
        movieRowCellRouterMock = MovieRowCellRouterMock()
        sutPresenter = MovieRowCellPresenter(movie: movieMock, interface: movieRowCellViewMock!, router: movieRowCellRouterMock!)
        movieRowCellViewMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        movieRowCellViewMock = nil
        movieRowCellRouterMock = nil
        super.tearDown()
    }
    
    func testGetMovie() {
        sutPresenter?.getMovie()
        XCTAssertTrue(movieRowCellViewMock!.isShowMovieCalled)
        XCTAssertTrue(movieRowCellViewMock!.movie?.id == movieMock.id)
    }
}

class MovieRowCellViewMock: MovieRowCellViewProtocol {
    var isShowMovieCalled: Bool = false
    var presenter: MovieRowCellPresenterProtocol?
    var movie: Movie?
    
    func showMovie(movie: Movie?) {
        isShowMovieCalled = true
        self.movie = movie
    }
}

class MovieRowCellRouterMock: MovieRowCellWireframeProtocol {
    var isOpenMovieCalled: Bool = false
    
    func openMovie(movie: Movie) {
        isOpenMovieCalled = true
    }
}
