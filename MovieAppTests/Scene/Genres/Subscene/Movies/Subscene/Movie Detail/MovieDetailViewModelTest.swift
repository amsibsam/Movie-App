//
//  MovieDetailViewModelTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

class MovieDetailViewModelTest: XCTestCase {
    private let disposeBag: DisposeBag = DisposeBag()
    private let dummyMovie: Movie = Movie.generateDummyMovie()
    private let movieDetailNavigatorMock = MovieDetailNavigatorMock()
    private let movieDetailInteractorMock = MovieDetailInteractorMock(networkService: NetworkServiceImpl())
    
    func testInit() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: MovieDetailNavigatorMock(), interactor: MovieDetailInteractorMock(networkService: NetworkServiceImpl()))
        
        XCTAssertNotNil(movieDetailViewModel)
    }
    
    func testGetMovieError() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        let expectation = XCTestExpectation(description: "testGetMovieError")
        
        var isMovieDriverTriggered = false
        var isErrorDriverTriggered = false
        movieDetailInteractorMock.isSuccess = false
        
        movieDetailViewModel.movieDriver.drive(onNext: { (_) in
            isMovieDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getMovie()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(isMovieDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testGetMovieSuccess() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        let expectation = XCTestExpectation(description: "testGetMovieError")
        
        var isMovieDriverTriggered = false
        var isErrorDriverTriggered = false
        
        movieDetailViewModel.movieDriver.drive(onNext: { (_) in
            isMovieDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getMovie()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isErrorDriverTriggered)
        XCTAssertTrue(isMovieDriverTriggered)
    }
    
    func testGetVideoError() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        let expectation = XCTestExpectation(description: "testGetMovieError")
        
        var isVideoDriverTriggered = false
        var isErrorDriverTriggered = false
        
        movieDetailInteractorMock.isSuccess = false
        movieDetailViewModel.videoDriver.drive(onNext: { (_) in
            isVideoDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getVideo()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isVideoDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testGetVideoSuccess() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        let expectation = XCTestExpectation(description: "testGetMovieError")
        
        var isVideoDriverTriggered = false
        var isErrorDriverTriggered = false
        
        movieDetailViewModel.videoDriver.drive(onNext: { (_) in
            isVideoDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getVideo()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isErrorDriverTriggered)
        XCTAssertTrue(isVideoDriverTriggered)
    }
    
    func testGetUserReviewsPageOutOfBounds() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        var isReviewRefreshDriverTriggered = false
        var isErrorDriverTriggered = false
        
        movieDetailViewModel.reviewRefreshDriver.drive(onNext: { (_) in
            isReviewRefreshDriverTriggered = true
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getUserReviews(page: 3)
        
        XCTAssertFalse(isErrorDriverTriggered)
        XCTAssertFalse(isReviewRefreshDriverTriggered)
    }
    
    func testGetUserReviewsErrorInteractor() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        var isReviewRefreshDriverTriggered = false
        var isErrorDriverTriggered = false
        
        let expcetation = XCTestExpectation(description: "testGetUserReviewsErrorInteractor")
        
        movieDetailInteractorMock.isSuccess = false
        movieDetailViewModel.reviewRefreshDriver.drive(onNext: { (_) in
            isReviewRefreshDriverTriggered = true
            expcetation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expcetation.fulfill()
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getUserReviews(page: 1)
        
        XCTAssertTrue(isErrorDriverTriggered)
        XCTAssertFalse(isReviewRefreshDriverTriggered)
    }
    
    func testGetUserReviewsSuccess() throws {
          let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
          
          var isReviewRefreshDriverTriggered = false
          var isErrorDriverTriggered = false
          
          let expcetation = XCTestExpectation(description: "testGetUserReviewsErrorInteractor")
          
          movieDetailViewModel.reviewRefreshDriver.drive(onNext: { (_) in
              isReviewRefreshDriverTriggered = true
              expcetation.fulfill()
          })
              .disposed(by: disposeBag)
          
          movieDetailViewModel.errorDriver.drive(onNext: { (_) in
              isErrorDriverTriggered = true
              expcetation.fulfill()
          })
              .disposed(by: disposeBag)
          
          movieDetailViewModel.getUserReviews(page: 1)
          
          XCTAssertFalse(isErrorDriverTriggered)
          XCTAssertTrue(isReviewRefreshDriverTriggered)
      }
    
    func testGetUserReviewsSuccessLoadMore() throws {
        let movieDetailViewModel = MovieDetailViewModel(movie: dummyMovie, navigator: movieDetailNavigatorMock, interactor: movieDetailInteractorMock)
        
        var isReviewRefreshDriverTriggered = false
        var isErrorDriverTriggered = false
        
        let expcetation = XCTestExpectation(description: "testGetUserReviewsErrorInteractor")
        
        var page = 1
        movieDetailViewModel.reviewRefreshDriver.drive(onNext: { (_) in
            if page == 2 {
                isReviewRefreshDriverTriggered = true
                expcetation.fulfill()
            } else {
                movieDetailViewModel.getUserReviews(page: 2)
            }
            page += 1
        })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expcetation.fulfill()
            })
            .disposed(by: disposeBag)
        
        movieDetailViewModel.getUserReviews(page: 1)
        
        wait(for: [expcetation], timeout: 1)
        
        XCTAssertFalse(isErrorDriverTriggered)
        XCTAssertTrue(isReviewRefreshDriverTriggered)
        XCTAssertTrue(movieDetailViewModel.userReviews.count == movieDetailInteractorMock.userReviews.count + 1)
    }
    
    override func tearDownWithError() throws {
        movieDetailInteractorMock.reset()
    }
}

class MovieDetailNavigatorMock: MovieDetailNavigator {
    
}

class MovieDetailInteractorMock: MovieDetailInteractor {
    var networkService: NetworkService
    var isSuccess: Bool = true
    var userReviews: [UserReview] = [UserReview.generateDummyUserReview()]
    
    required init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getMovie(withId id: Int, onSuccess: @escaping (Movie) -> Void, onError: @escaping (String) -> Void) {
        if isSuccess {
            onSuccess(Movie.generateDummyMovie())
        } else {
            onError("")
        }
    }
    
    func getVideo(withMovieId id: Int, onSuccess: @escaping (Video) -> Void, onError: @escaping (String) -> Void) {
        if isSuccess {
            onSuccess(Video.generateDummyVideo())
        } else {
            onError("")
        }
    }
    
    func getUserReview(onMovieId id: Int, page: Int, onSuccess: @escaping ([UserReview], Int) -> Void, onError: @escaping (String) -> Void) {
        if isSuccess {
            onSuccess(userReviews, 2)
        } else {
            onError("")
        }
    }
    
    func reset() {
        isSuccess = true
    }
    
}
