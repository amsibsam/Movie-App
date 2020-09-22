//
//  GenreCellInteractorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import Moya

class GenreCellInteractorTest: XCTestCase {
    
    var sutInteractor: GenreCellInteractor?
    var mockPresenter: GenreCellInteractorPresenterMock?
    var networkServiceMock: NetworkServiceMock?
    
    override func setUp() {
        sutInteractor = GenreCellInteractor()
        mockPresenter = GenreCellInteractorPresenterMock()
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
    
    func testGetMoviesSucceed() {
        networkServiceMock?.successResponse = DiscoveryResponse(page: 1, totalResults: 1, totalPages: 1, results: [Movie.generateDummyMovie()])
        sutInteractor?.getMovies(withGenreId: 1)
        XCTAssertTrue(mockPresenter!.isOnGetMoviesSucceedCalled)
        XCTAssertFalse(mockPresenter!.movies.isEmpty)
    }
    
    func testGetMoviesFailed() {
        networkServiceMock?.isSuccess = false
        let errorResponse = MoyaError.requestMapping("error")
        networkServiceMock?.errorResponse = errorResponse
        sutInteractor?.getMovies(withGenreId: 1)
        XCTAssertTrue(mockPresenter!.isOnGetMoviesFailedCalled)
        XCTAssertEqual(mockPresenter!.errorMessage, errorResponse.localizedDescription)
    }
}

class GenreCellInteractorPresenterMock: GenreCellInteractorOutputProtocol {
    
    var isOnGetMoviesSucceedCalled: Bool = false
    var isOnGetMoviesFailedCalled: Bool = false
    var movies: [Movie] = []
    var errorMessage: String = ""
    
    func onGetMoviesFailed(errorMessage: String) {
        isOnGetMoviesFailedCalled = true
        self.errorMessage = errorMessage
    }
    
    func onGetMoviesSucceed(movies: [Movie]) {
        isOnGetMoviesSucceedCalled = true
        self.movies = movies
    }
}
