//
//  MovieDetailPresenterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieDetailPresenterTest: XCTestCase {
    
    var sutPresenter: MovieDetailPresenter?
    var movieDetailViewMock: MovieDetailViewMock?
    var movieDetailInteractorMock: MovieDetailInteractorMock?
    var movieDetailRouterMock: MovieDetailRouterMock?
    var movieMock: Movie = Movie.generateDummyMovie()
    
    override func setUp() {
        movieDetailViewMock = MovieDetailViewMock()
        movieDetailInteractorMock = MovieDetailInteractorMock()
        movieDetailRouterMock = MovieDetailRouterMock()
        sutPresenter = MovieDetailPresenter(movie: movieMock, interface: movieDetailViewMock!, router: movieDetailRouterMock!, interactor: movieDetailInteractorMock!)
        movieDetailInteractorMock?.presenter = sutPresenter
        movieDetailViewMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        movieDetailViewMock = nil
        movieDetailInteractorMock = nil
        movieDetailRouterMock = nil
        super.tearDown()
    }
    
    func testGetMoviePosterNil() {
        sutPresenter?.getMoviePoster()
        XCTAssertFalse(movieDetailViewMock!.isShowMoviePosterCalled)
    }
    
    func testGetMoviePosterSucceed() {
        sutPresenter = MovieDetailPresenter(movie: Movie.generateDummyMovieWithPoster(), interface: movieDetailViewMock!, router: movieDetailRouterMock!, interactor: movieDetailInteractorMock!)
        sutPresenter?.getMoviePoster()
        XCTAssertTrue(movieDetailViewMock!.isShowMoviePosterCalled)
    }
    
    func testGetUserReviewSucceed() {
        sutPresenter?.getUserReview(page: 1)
        XCTAssertTrue(movieDetailViewMock!.isRefreshTableViewCalled)
        XCTAssertTrue(sutPresenter?.userReviews.count == 1)
    }
    
    func testGetUserReviewLoadMore() {
        sutPresenter?.getUserReview(page: 1)
        XCTAssertTrue(movieDetailViewMock!.isRefreshTableViewCalled)
        XCTAssertTrue(sutPresenter?.userReviews.count == 1)
        sutPresenter?.getUserReview(page: 2)
        XCTAssertTrue(movieDetailViewMock!.isRefreshTableViewCalled)
        XCTAssertTrue(sutPresenter?.userReviews.count == movieDetailInteractorMock!.userReviewsResponse.count + 1)
    }
}

class MovieDetailViewMock: MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    var isShowMoviePosterCalled: Bool = false
    var isRefreshTableViewCalled: Bool = false
    
    func showMoviePoster(moviePosterUrl: URL) {
        isShowMoviePosterCalled = true
    }
    
    func refreshTableView() {
        isRefreshTableViewCalled = true
    }
    
}

class MovieDetailInteractorMock: MovieDetailInteractorInputProtocol {
    var isSuccess: Bool = true
    
    var networkService: NetworkService?
    
    var presenter: MovieDetailInteractorOutputProtocol?
    
    var userReviewsResponse: [UserReview] = [UserReview.generateDummyUserReview()]
    
    func getUserReviews(on movieId: Int, page: Int) {
        if isSuccess {
            presenter?.onGetUserReviewsSucceed(userReviews: userReviewsResponse, page: page)
        } else {
            presenter?.onGetUserReviewFailed(errorMessage: "error")
        }
    }
    
}

class MovieDetailRouterMock: MovieDetailWireframeProtocol {
    
}
