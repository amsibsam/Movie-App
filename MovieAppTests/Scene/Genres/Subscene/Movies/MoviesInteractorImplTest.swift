//
//  MoviesInteractorImplTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MoviesInteractorImplTest: XCTestCase {
    var moviesInteractorImpl: MoviesInteractorImpl!
    private let networkServiceMock: NetworkServiceMock = NetworkServiceMock(urlSessionService: URLSessionServiceMock())
    
    func testInit() throws {
        moviesInteractorImpl = MoviesInteractorImpl(networkService: networkServiceMock)
        
        XCTAssertNotNil(moviesInteractorImpl)
        XCTAssertNotNil(moviesInteractorImpl.networkService)
    }
    
    func testGetMoviesError() {
        moviesInteractorImpl = MoviesInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.errorResponse = .invalidResponse
        
        let expectation = XCTestExpectation(description: "testGetMoviesError")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        moviesInteractorImpl.getMovies(withGenreId: 1, page: 1, onSuccess: { (genres) in
            isSuccess = true
            expectation.fulfill()
        }) { (error) in
            isError = true
            errorResult = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(isError)
        
    }
    
    func testGetMoviesSuccess() {
        moviesInteractorImpl = MoviesInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = DiscoveryResponse(page: 1, totalResults: 1, totalPages: 1, results: [Movie.generateDummyMovie()])
        
        let expectation = XCTestExpectation(description: "testGetGenresSuccess")
        var successResult: [Movie]?
        var isSuccess = false
        var isError = false
        moviesInteractorImpl.getMovies(withGenreId: 1, page: 1, onSuccess: { (movies) in
            isSuccess = true
            successResult = movies
            expectation.fulfill()
        }) { (error) in
            isError = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(successResult)
        XCTAssertTrue(isSuccess)
        XCTAssertFalse(isError)
        
    }
}
