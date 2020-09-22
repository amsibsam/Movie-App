//
//  MovieDetailInteractorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import Moya

class MovieDetailInteractorTest: XCTestCase {
    
    var sutInteractor: MovieDetailInteractor?
    var mockPresenter: MovieDetailInteractorPresenterMock?
    var networkServiceMock: NetworkServiceMock?
    
    override func setUp() {
        sutInteractor = MovieDetailInteractor()
        mockPresenter = MovieDetailInteractorPresenterMock()
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
    
    func testGetUserReviewsSuccess() {
        networkServiceMock?.isSuccess = true
        let page = 1
        let userReviewsResponse = UserReviewResponse(id: 1, page: page, results: [UserReview.generateDummyUserReview()], totalPages: 1, totalResults: 1)
        networkServiceMock?.successResponse = userReviewsResponse
        sutInteractor?.getUserReviews(on: 1, page: page)
        XCTAssertTrue(mockPresenter!.isOnGetMovieDetailSucceedCalled)
        XCTAssertFalse(mockPresenter!.isOnGetMovieDetailFailedCalled)
        XCTAssertEqual(mockPresenter!.page, page)
        XCTAssertTrue(userReviewsResponse.results.count == mockPresenter?.userReviews.count)
    }
    
    func testGetUserReviewFailed() {
        networkServiceMock?.isSuccess = false
        let errorResponse = MoyaError.requestMapping("error")
        networkServiceMock?.errorResponse = errorResponse
        sutInteractor?.getUserReviews(on: 1, page: 1)
        XCTAssertFalse(mockPresenter!.isOnGetMovieDetailSucceedCalled)
        XCTAssertTrue(mockPresenter!.isOnGetMovieDetailFailedCalled)
        XCTAssertTrue(errorResponse.localizedDescription == mockPresenter?.errorMessage)
    }
}

class MovieDetailInteractorPresenterMock: MovieDetailInteractorOutputProtocol {
    
    var isOnGetMovieDetailSucceedCalled: Bool = false
    var isOnGetMovieDetailFailedCalled: Bool = false
    var userReviews: [UserReview] = []
    var page: Int = 0
    var errorMessage: String = ""
    
    func onGetUserReviewsSucceed(userReviews: [UserReview]) {
        self.userReviews = userReviews
        self.page += 1
        isOnGetMovieDetailSucceedCalled = true
    }
    
    func onGetUserReviewFailed(errorMessage: String) {
        isOnGetMovieDetailFailedCalled = true
        self.errorMessage = errorMessage
    }
    
}
