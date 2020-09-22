//
//  MoviesPresenterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MoviesPresenterTest: XCTestCase {
    
    var sutPresenter: MoviesPresenter?
    var moviesViewMock: MoviesViewMock?
    var moviesInteractorMock: MoviesInteractorMock?
    var moviesRouterMock: MoviesRouterMock?
    var mockGenre: Genre = Genre(id: 1, name: "dummy")
    
    override func setUp() {
        moviesViewMock = MoviesViewMock()
        moviesInteractorMock = MoviesInteractorMock()
        moviesRouterMock = MoviesRouterMock()
        sutPresenter = MoviesPresenter(genre: mockGenre, interface: moviesViewMock!, interactor: moviesInteractorMock, router: moviesRouterMock!)
        moviesInteractorMock?.presenter = sutPresenter
        moviesViewMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        moviesViewMock = nil
        moviesInteractorMock = nil
        moviesRouterMock = nil
        super.tearDown()
    }
    
    func testGetTitle() {
        sutPresenter?.getTitle()
        XCTAssertTrue(moviesViewMock!.isShowTitleCalled)
        XCTAssertEqual(moviesViewMock?.title, mockGenre.name)
    }
    
    func testGetMoviesSucceed() {
        moviesInteractorMock?.isSuccess = true
        sutPresenter?.getMovies(page: 1)
        XCTAssertTrue(moviesViewMock!.isShowLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isStopLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isReloadTableViewCalled)
        XCTAssertFalse(sutPresenter!.movies.isEmpty)
    }
    
    func testGetMoviesSucceedLoadMore() {
        moviesInteractorMock?.isSuccess = true
        moviesInteractorMock?.moviesResponse = [Movie.generateDummyMovie()]
        sutPresenter?.getMovies(page: 1)
        XCTAssertTrue(moviesViewMock!.isShowLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isStopLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isReloadTableViewCalled)
        moviesViewMock?.reset()
        sutPresenter?.getMovies(page: 2)
        XCTAssertFalse(moviesViewMock!.isShowLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isStopLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isReloadTableViewCalled)
        XCTAssertTrue(sutPresenter!.movies.count == moviesInteractorMock!.moviesResponse.count + 1)
    }

    func testGetMoviesFailed() {
        moviesInteractorMock?.isSuccess = false
        sutPresenter?.getMovies(page: 1)
        XCTAssertFalse(moviesViewMock!.isReloadTableViewCalled)
        XCTAssertTrue(moviesViewMock!.isShowLoadingCalled)
        XCTAssertTrue(moviesViewMock!.isStopLoadingCalled)
        XCTAssertTrue(sutPresenter!.movies.isEmpty)
        XCTAssertTrue(moviesRouterMock!.isShowErrorCalled)
    }
    
    func testOpenMovieDetailOutOfBound() {
        sutPresenter?.openMovieDetail(atIndex: 0)
        XCTAssertFalse(moviesRouterMock!.isOpenMovieDetailCalled)
    }
    
    func testOpenMovieDetailSuccess() {
        sutPresenter?.getMovies(page: 1)
        sutPresenter?.openMovieDetail(atIndex: 0)
        XCTAssertTrue(moviesRouterMock!.isOpenMovieDetailCalled)
    }
    
}

class MoviesViewMock: MoviesViewProtocol {
    var presenter: MoviesPresenterProtocol?
    var isReloadTableViewCalled: Bool = false
    var isShowTitleCalled: Bool = false
    var isShowLoadingCalled: Bool = false
    var isStopLoadingCalled: Bool = false
    var title: String = ""
    
    func reloadTableView() {
        isReloadTableViewCalled = true
    }
    
    func showTitle(title: String) {
        self.title = title
        isShowTitleCalled = true
    }
    
    func showLoading() {
        isShowLoadingCalled = true
    }
    
    func stopLoading() {
        isStopLoadingCalled = true
    }
    
    func reset() {
        isShowTitleCalled = false
        isShowLoadingCalled = false
        isStopLoadingCalled = false
    }
}

class MoviesInteractorMock: MoviesInteractorInputProtocol {
    var isSuccess: Bool = true
    
    var networkService: NetworkService?
    
    var presenter: MoviesInteractorOutputProtocol?
    
    var moviesResponse: [Movie] = [Movie.generateDummyMovie()]
    
    func getMovies(withGenreId id: Int, page: Int) {
        if isSuccess {
            presenter?.onGetMoviesSucceed(movies: moviesResponse, page: page)
        } else {
            presenter?.onGetMoviesFailed(errorMessage: "Error")
        }
    }
}

class MoviesRouterMock: MoviesWireframeProtocol {
    
    var isOpenMovieDetailCalled: Bool = false
    var isShowErrorCalled: Bool = false
    var errorMessag: String = ""
    
    func openMovieDetail(movie: Movie) {
        isOpenMovieDetailCalled = true
    }
    
    func showError(errorMessage: String) {
        self.errorMessag = errorMessage
        isShowErrorCalled = true
    }
    
}
