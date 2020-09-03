//
//  GenreCellViewModelTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

class GenreCellViewModelTest: XCTestCase {
    let disposeBag: DisposeBag = DisposeBag()
    let genresNavigatorMock = GenresNavigatorMock()
    var genresInteractorMock: GenresInteractorMock!
    var genresViewModel: GenresViewModel!
    var genreCellViewModel: GenreCellViewModel!
    
    override func setUpWithError() throws {
        genresInteractorMock = GenresInteractorMock(networkService: NetworkServiceImpl())
        genresViewModel = GenresViewModel(navigator: genresNavigatorMock, interactor: genresInteractorMock)
    }
    
    override func tearDownWithError() throws {
        genresNavigatorMock.reset()
        genresInteractorMock.reset()
    }
    
    func testInit() throws {
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        
        XCTAssertNotNil(genreCellViewModel)
        XCTAssertTrue(genreCellViewModel.movies.isEmpty)
    }
    
    func testGetMoviesErrorIndex() throws {
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        genresInteractorMock.isSuccess = true
        var isRefresDriverTriggered = false
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetMoviesErrorIndex")
        
        genreCellViewModel.refreshDriver.drive(onNext: { (_) in
            isRefresDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.getMovies()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isRefresDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testGetMoviesErrorInteractor() throws {
        genresViewModel.genres = [Genre(id: 0, name: "dummy")]
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        genresInteractorMock.isSuccess = false
        var isRefresDriverTriggered = false
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetMoviesErrorInteractor")
        
        genreCellViewModel.refreshDriver.drive(onNext: { (_) in
            isRefresDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.getMovies()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isRefresDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testGetMoviesSuccess() throws {
        genresViewModel.genres = [Genre(id: 0, name: "dummy")]
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        genresInteractorMock.isSuccess = true
        var isRefresDriverTriggered = false
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetMoviesSuccess")
        
        genreCellViewModel.refreshDriver.drive(onNext: { (_) in
            isRefresDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.getMovies()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isErrorDriverTriggered)
        XCTAssertTrue(isRefresDriverTriggered)
    }
    
    func testGetGenreErrorIndex() throws {
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        var isGenreDriverTriggered = false
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetGenreErrorIndex")
        
        genreCellViewModel.genreDriver.drive(onNext: { (_) in
            isGenreDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.getGenre()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isGenreDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testGetGenreSuccess() throws {
        genresViewModel.genres = [Genre(id: 0, name: "dummy")]
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        var isGenreDriverTriggered = false
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetGenreErrorIndex")
        
        genreCellViewModel.genreDriver.drive(onNext: { (_) in
            isGenreDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.getGenre()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(isErrorDriverTriggered)
        XCTAssertTrue(isGenreDriverTriggered)
    }
    
    func testOpenMoviesErrorIndex() throws {
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetGenreErrorIndex")
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.openMovies()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(genresNavigatorMock.isOpenMoviesCalled)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testOpenMoviesSuccess() throws {
        genresViewModel.genres = [Genre(id: 0, name: "dummy")]
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        genreCellViewModel.openMovies()
        
        XCTAssertTrue(genresNavigatorMock.isOpenMoviesCalled)
    }
    
    func testOpenMovieErrorIndex() throws {
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        var isErrorDriverTriggered = false
        let expectation = XCTestExpectation(description: "testGetGenreErrorIndex")
        
        genreCellViewModel.errorDriver.drive(onNext: { (_) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        
        genreCellViewModel.openMovie(atIndex: 0)
        
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(genresNavigatorMock.isOpenMovieCalled)
        XCTAssertTrue(isErrorDriverTriggered)
    }
    
    func testOpenMovieSuccess() throws {
        genreCellViewModel = GenreCellViewModel(cellIndex: 0, genresViewModel: genresViewModel, interactor: genresInteractorMock)
        genreCellViewModel.movies = [Movie.generateDummyMovie()]
        genreCellViewModel.openMovie(atIndex: 0)
        
        XCTAssertTrue(genresNavigatorMock.isOpenMovieCalled)
    }
}
