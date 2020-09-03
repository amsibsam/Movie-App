//
//  MovieDetailInteractorImplTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieDetailInteractorImplTest: XCTestCase {
    var movieDetailInteractorImpl: MovieDetailInteractorImpl!
    private let networkServiceMock: NetworkServiceMock = NetworkServiceMock(urlSessionService: URLSessionServiceMock())
    
    func testInit() throws {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        
        XCTAssertNotNil(movieDetailInteractorImpl)
        XCTAssertNotNil(movieDetailInteractorImpl.networkService)
    }
    
    func testGetMovieError() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.errorResponse = .invalidResponse
        
        let expectation = XCTestExpectation(description: "testGetMovieError")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getMovie(withId: 1, onSuccess: { (_) in
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
    
    func testGetMovieSuccess() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = Movie.generateDummyMovie()
        
        let expectation = XCTestExpectation(description: "testGetMovieSuccess")
        var successResult: Movie?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getMovie(withId: 1, onSuccess: { (movie) in
            isSuccess = true
            successResult = movie
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
    
    func testGetVideoError() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.errorResponse = .invalidResponse
        
        let expectation = XCTestExpectation(description: "testGetVideoError")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getVideo(withMovieId: 1, onSuccess: { (_) in
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
    
    func testGetVideoErrorNotTrailer() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = VideoResponse(id: 1, results: [Video(id: "1", iso639_1: nil, iso3166_1: nil, key: nil, name: nil, site: "YouTube", size: nil, type: "Not Trailer")])
        
        let expectation = XCTestExpectation(description: "testGetVideoErrorNotTrailer")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getVideo(withMovieId: 1, onSuccess: { (video) in
            isSuccess = true
            expectation.fulfill()
        }) { (error) in
            errorResult = error
            isError = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(isError)
        
    }
    
    func testGetVideoErrorNotYoutube() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = VideoResponse(id: 1, results: [Video(id: "1", iso639_1: nil, iso3166_1: nil, key: nil, name: nil, site: "Vimeo", size: nil, type: "Trailer")])
        
        let expectation = XCTestExpectation(description: "testGetVideoErrorNotYoutube")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getVideo(withMovieId: 1, onSuccess: { (video) in
            isSuccess = true
            expectation.fulfill()
        }) { (error) in
            errorResult = error
            isError = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(isError)
        
    }
    
    func testGetVideoSucceess() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = VideoResponse(id: 1, results: [Video(id: "1", iso639_1: nil, iso3166_1: nil, key: nil, name: nil, site: "YouTube", size: nil, type: "Trailer")])
        
        let expectation = XCTestExpectation(description: "testGetVideoSucceess")
        var successResult: Video?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getVideo(withMovieId: 1, onSuccess: { (video) in
            successResult = video
            isSuccess = true
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
    
    func testGetUserReviewError() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.errorResponse = .invalidResponse
        
        let expectation = XCTestExpectation(description: "testGetUserReviewError")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getUserReview(onMovieId: 1, page: 1, onSuccess: { (_, _) in
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
    
    func testGetUserReviewSuccess() {
        movieDetailInteractorImpl = MovieDetailInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = UserReviewResponse(id: 1, page: 1, results: [UserReview.generateDummyUserReview()], totalPages: 1, totalResults: 1)
        
        let expectation = XCTestExpectation(description: "testGetUserReviewSuccess")
        var successResult: [UserReview]?
        var totalPagesResult = 0
        var isSuccess = false
        var isError = false
        movieDetailInteractorImpl.getUserReview(onMovieId: 1, page: 1, onSuccess: { (userReviews, totalPages) in
            isSuccess = true
            totalPagesResult = totalPages
            successResult = userReviews
            expectation.fulfill()
        }) { (error) in
            isError = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(successResult)
        XCTAssertTrue(totalPagesResult == 1)
        XCTAssertTrue(isSuccess)
        XCTAssertFalse(isError)
        
    }
}
