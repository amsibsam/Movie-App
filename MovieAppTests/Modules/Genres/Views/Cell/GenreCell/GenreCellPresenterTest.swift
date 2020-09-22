//
//  GenreCellPresenterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class GenreCellPresenterTest: XCTestCase {
    
    var sutPresenter: GenreCellPresenter?
    var genreCellViewMock: GenreCellViewMock?
    var genreCellInteractorMock: GenreCellInteractorMock?
    var genreCellRouterMock: GenreCellRouterMock?
    var genreMock: Genre = Genre(id: 1, name: "dummy")
    
    override func setUp() {
        genreCellViewMock = GenreCellViewMock()
        genreCellInteractorMock = GenreCellInteractorMock()
        genreCellRouterMock = GenreCellRouterMock()
        sutPresenter = GenreCellPresenter(genre: genreMock, interface: genreCellViewMock!, interactor: genreCellInteractorMock, router: genreCellRouterMock!)
        genreCellInteractorMock?.presenter = sutPresenter
        genreCellViewMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        genreCellViewMock = nil
        genreCellInteractorMock = nil
        genreCellRouterMock = nil
        super.tearDown()
    }
    
    func testGetMoviesSucceed() {
        sutPresenter?.getMovies()
        XCTAssertTrue(genreCellViewMock!.isShowLoadingCalled)
        XCTAssertTrue(genreCellViewMock!.isStopLoadingCalled)
        XCTAssertTrue(genreCellViewMock!.isReloadTableViewCalled)
        XCTAssertFalse(genreCellViewMock!.isShowErrorCalled)
    }
    
    func testGetMoviesFailed() {
        genreCellInteractorMock?.isSuccess = false
        sutPresenter?.getMovies()
        XCTAssertTrue(genreCellViewMock!.isShowLoadingCalled)
        XCTAssertTrue(genreCellViewMock!.isStopLoadingCalled)
        XCTAssertTrue(genreCellViewMock!.isShowErrorCalled)
    }
    
    func testGetGenre() {
        sutPresenter?.getGenre()
        XCTAssertTrue(genreCellViewMock!.isShowGenreCalled)
    }
    
    func testOpenMovieOutOfBound() {
        sutPresenter?.openMovie(atIndex: 0)
        XCTAssertFalse(genreCellRouterMock!.isOpenMovieCalled)
    }
    
    func testOpenMovieSucceed() {
        sutPresenter?.getMovies()
        sutPresenter?.openMovie(atIndex: 0)
        XCTAssertTrue(genreCellRouterMock!.isOpenMovieCalled)
    }
    
    func testOpenMovies() {
        sutPresenter?.openMovies()
        XCTAssertTrue(genreCellRouterMock!.isOpenMoviesCalled)
    }
}

class GenreCellViewMock: GenreCellViewProtocol {
    
    var presenter: GenreCellPresenterProtocol?
    var isReloadTableViewCalled: Bool = false
    var isShowLoadingCalled: Bool = false
    var isStopLoadingCalled: Bool = false
    var isShowErrorCalled: Bool = false
    var isShowGenreCalled: Bool = false
    var errorMessage: String?
    var genre: Genre?
    
    func reloadTableView() {
        isReloadTableViewCalled = true
    }
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func stopLoading() {
        isStopLoadingCalled = true
    }
    
    func showError(errorMessage: String) {
        self.errorMessage = errorMessage
        isShowErrorCalled = true
    }
    
    func showGenre(genre: Genre) {
        self.genre = genre
        isShowGenreCalled = true
    }
}

class GenreCellInteractorMock: GenreCellInteractorInputProtocol {
    
    var isSuccess: Bool = true
    
    var networkService: NetworkService?
    
    var presenter: GenreCellInteractorOutputProtocol?
    
    var movies: [Movie] = [Movie.generateDummyMovie()]
    
    var errorMessage: String = "Error"
    
    func getMovies(withGenreId id: Int) {
        if isSuccess {
            presenter?.onGetMoviesSucceed(movies: movies)
        } else {
            presenter?.onGetMoviesFailed(errorMessage: errorMessage)
        }
    }
}

class GenreCellRouterMock: GenreCellWireframeProtocol {
    var isOpenMoviesCalled: Bool = false
    var isOpenMovieCalled: Bool = false
    var genre: Genre?
    var movie: Movie?
    
    func openMovies(withGenre genre: Genre) {
        self.genre = genre
        isOpenMoviesCalled = true
    }
    
    func openMovie(movie: Movie) {
        self.movie = movie
        isOpenMovieCalled = true
    }
    
}
