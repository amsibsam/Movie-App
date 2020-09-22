//
//  MovieInfoCellInteractorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import Moya

class MovieInfoCellInteractorTest: XCTestCase {
    var sutInteractor: MovieInfoCellInteractor?
    var presenterMock: MovieInfoCellPresenterMock?
    var networkServiceMock: NetworkServiceMock?
    
    override func setUp() {
        networkServiceMock = NetworkServiceMock()
        presenterMock = MovieInfoCellPresenterMock()
        sutInteractor = MovieInfoCellInteractor()
        sutInteractor?.presenter = presenterMock
        sutInteractor?.networkService = networkServiceMock
        super.setUp()
    }
    
    override func tearDown() {
        sutInteractor = nil
        networkServiceMock = nil
        presenterMock = nil
        super.tearDown()
    }
    
    func testGetMovieSucceed() {
        networkServiceMock?.isSuccess = true
        let movieResponse = Movie.generateDummyMovie()
        networkServiceMock?.successResponse = movieResponse
        sutInteractor?.getMovie(withId: 1)
        XCTAssertEqual(presenterMock!.movie!.id, movieResponse.id)
        XCTAssertTrue(presenterMock!.isOnGetMovieSucceedCalled)
        XCTAssertFalse(presenterMock!.isOnGetMovieFailedCalled)
    }
    
    func testGetMovieFailed() {
        networkServiceMock?.isSuccess = false
        let errorResponse = MoyaError.requestMapping("Error")
        networkServiceMock?.errorResponse = errorResponse
        networkServiceMock?.successResponse = Movie.generateDummyMovie()
        sutInteractor?.getMovie(withId: 1)
        XCTAssertFalse(presenterMock!.isOnGetMovieSucceedCalled)
        XCTAssertEqual(presenterMock!.errorMessage, errorResponse.localizedDescription)
        XCTAssertTrue(presenterMock!.isOnGetMovieFailedCalled)
    }
    
}

class MovieInfoCellPresenterMock: MovieInfoCellInteractorOutputProtocol {
    var isOnGetMovieSucceedCalled: Bool = false
    var isOnGetMovieFailedCalled: Bool = false
    var movie: Movie?
    var errorMessage: String?
    
    func onGetMovieSucceed(movie: Movie) {
        isOnGetMovieSucceedCalled = true
        self.movie = movie
    }
    
    func onGetMovieFailed(errorMessage: String) {
        isOnGetMovieFailedCalled = true
        self.errorMessage = errorMessage
    }
    
    
}
