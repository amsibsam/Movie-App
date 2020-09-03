//
//  MoviesViewModelTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

class MoviesViewModelTest: XCTestCase {
    let disposeBag: DisposeBag = DisposeBag()
    let moviesNavigatorMock = MoviesNavigatorMock()
    var moviesInteractorMock: MoviesInteractorMock!
    
    override func setUpWithError() throws {
        moviesInteractorMock = MoviesInteractorMock(networkService: NetworkServiceImpl())
    }
    
    override func tearDownWithError() throws {
        moviesNavigatorMock.reset()
    }
    
    func testInit() throws {
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 0, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        
        XCTAssertNotNil(moviesViewModel)
    }
    
    func testOpenMovieDetailError() throws {
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 1, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        moviesViewModel.openMovieDetail(atIndex: 0)
        
        XCTAssertFalse(moviesNavigatorMock.isOpenMovieDetailCalled)
    }
    
    func testOpenMovieDetailSuccess() throws {
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 1, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        moviesViewModel.movies.append(Movie.generateDummyMovie())
        moviesViewModel.openMovieDetail(atIndex: 0)
        
        XCTAssertTrue(moviesNavigatorMock.isOpenMovieDetailCalled)
    }
    
    func testGetTitle() throws {
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 0, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        var isTitleDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetTitle")
        moviesViewModel.titleDriver.drive(onNext: { (_) in
            isTitleDriverTriggered = true
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        moviesViewModel.getTitle()
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(isTitleDriverTriggered)
    }
    
    func testGetMoviesSuccess() throws {
        moviesInteractorMock.movies = [Movie.generateDummyMovie(), Movie.generateDummyMovie()]
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 0, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        moviesViewModel.movies = [Movie.generateDummyMovie(), Movie.generateDummyMovie()]
        let expectation = XCTestExpectation(description: "testGetMoviesSuccess")
        var isRefreshDriverTriggered = false
        moviesViewModel.refreshDriver.drive(onNext: { (_) in
            isRefreshDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        moviesViewModel.getMovies(page: 1)
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(isRefreshDriverTriggered)
        XCTAssert(moviesInteractorMock.movies.count == moviesViewModel.movies.count)
    }
    
    func testGetMoviesLoadMore() throws {
        moviesInteractorMock.movies = [Movie.generateDummyMovie(), Movie.generateDummyMovie()]
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 0, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        moviesViewModel.movies = [Movie.generateDummyMovie(), Movie.generateDummyMovie()]
        let expectation = XCTestExpectation(description: "testGetMoviesSuccess")
        var isRefreshDriverTriggered = false
        moviesViewModel.refreshDriver.drive(onNext: { (_) in
            isRefreshDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        moviesViewModel.getMovies(page: 2)
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(isRefreshDriverTriggered)
        XCTAssert(moviesInteractorMock.movies.count + 2 == moviesViewModel.movies.count)
    }
    
    func testGetMoviesError() throws {
        let moviesViewModel = MoviesViewModel(genre: Genre(id: 0, name: ""), navigator: moviesNavigatorMock, interactor: moviesInteractorMock)
        moviesInteractorMock.isSuccess = false
        let expectation = XCTestExpectation(description: "testGetMoviesError")
        var isRefreshDriverTriggered = false
        var isErrorDriverTriggered = false
        
        moviesViewModel.refreshDriver.drive(onNext: { (_) in
            isRefreshDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        moviesViewModel.errorDriver.drive(onNext: { (error) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        moviesViewModel.getMovies(page: 1)
        wait(for: [expectation], timeout: 2)
        XCTAssertFalse(isRefreshDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
}
