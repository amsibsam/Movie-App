//
//  MoviesInteractorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import Moya

class MoviesInteractorTest: XCTestCase {
    
    var sutInteractor: MoviesInteractor?
    var mockPresenter: MoviesInteractorPresenterMock?
    var networkServiceMock: NetworkServiceMock?
    
    override func setUp() {
        sutInteractor = MoviesInteractor()
        mockPresenter = MoviesInteractorPresenterMock()
        networkServiceMock = NetworkServiceMock()
        sutInteractor?.networkService = networkServiceMock
        sutInteractor?.presenter = mockPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutInteractor = nil
        mockPresenter = nil
        networkServiceMock = nil
        super.tearDown()
    }
    
    func testGetGenresSucceed() {
        networkServiceMock?.isSuccess = true
        let page = 1
        let discoveryResponse = DiscoveryResponse(page: page, totalResults: 1, totalPages: 1, results: [Movie.generateDummyMovie()])
        networkServiceMock?.successResponse = discoveryResponse
        sutInteractor?.getMovies(withGenreId: 1, page: page)
        XCTAssertTrue(mockPresenter!.isOnGetMoviesSucceedCalled)
        XCTAssertFalse(mockPresenter!.isOnGetMoviesFailedCalled)
        XCTAssertEqual(mockPresenter!.page, page)
        XCTAssertTrue(discoveryResponse.results?.count == mockPresenter?.movies.count)
    }
    
    func testGetGenresFailed() {
        networkServiceMock?.isSuccess = false
        let errorResponse = MoyaError.requestMapping("error")
        networkServiceMock?.errorResponse = errorResponse
        sutInteractor?.getMovies(withGenreId: 1, page: 1)
        XCTAssertFalse(mockPresenter!.isOnGetMoviesSucceedCalled)
        XCTAssertTrue(mockPresenter!.isOnGetMoviesFailedCalled)
        XCTAssertTrue(errorResponse.localizedDescription == mockPresenter?.errorMessage)
    }
}

class MoviesInteractorPresenterMock: MoviesInteractorOutputProtocol {
    
    var isOnGetMoviesSucceedCalled: Bool = false
    var isOnGetMoviesFailedCalled: Bool = false
    var movies: [Movie] = []
    var page: Int = 0
    var errorMessage: String = ""
    
    func onGetMoviesSucceed(movies: [Movie], page: Int) {
        self.movies = movies
        self.page = page
        isOnGetMoviesSucceedCalled = true
    }
    
    func onGetMoviesFailed(errorMessage: String) {
        self.errorMessage = errorMessage
        isOnGetMoviesFailedCalled = true
    }
}
