//
//  GenresViewModelTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

class GenresViewModelTest: XCTestCase {
    let disposeBag: DisposeBag = DisposeBag()
    let genresNavigatorMock = GenresNavigatorMock()
    var genresInteractorMock: GenresInteractorMock!
    
    override func setUpWithError() throws {
        genresInteractorMock = GenresInteractorMock(networkService: NetworkServiceImpl())
    }
    
    override func tearDownWithError() throws {
        genresNavigatorMock.reset()
    }

    func testInit() throws {
        let genresViewModel = GenresViewModel(navigator: genresNavigatorMock, interactor: genresInteractorMock)
        
        XCTAssertNotNil(genresViewModel)
    }
    
    func testOpenMovies() throws {
        let genresViewModel = GenresViewModel(navigator: genresNavigatorMock, interactor: genresInteractorMock)
        genresViewModel.openMovies(withGenre: Genre(id: 1, name: "dummy genre"))
        
        XCTAssertTrue(genresNavigatorMock.isOpenMoviesCalled)
    }
    
    func testOpenMovie() throws {
        let genresViewModel = GenresViewModel(navigator: genresNavigatorMock, interactor: genresInteractorMock)
        genresViewModel.openMovie(Movie.generateDummyMovie())
        
        XCTAssertTrue(genresNavigatorMock.isOpenMovieCalled)
    }
    
    func testGetGenresSuccess() throws {
        let genresViewModel = GenresViewModel(navigator: genresNavigatorMock, interactor: genresInteractorMock)
        let expectation = XCTestExpectation(description: "testGetGenresSuccess")
        var isRefreshDriverTriggered = false
        genresViewModel.refreshDriver.drive(onNext: { (_) in
            isRefreshDriverTriggered = true
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        genresViewModel.getGenres()
        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(isRefreshDriverTriggered)
    }
    
    func testGetGenresError() throws {
        let genresViewModel = GenresViewModel(navigator: genresNavigatorMock, interactor: genresInteractorMock)
        genresInteractorMock.isSuccess = false
        let expectation = XCTestExpectation(description: "testGetGenresSuccess")
        var isRefreshDriverTriggered = false
        var isErrorDriverTriggered = false
        
        genresViewModel.refreshDriver.drive(onNext: { (_) in
            isRefreshDriverTriggered = true
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        
        genresViewModel.errorDriver.drive(onNext: { (error) in
            isErrorDriverTriggered = true
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        
        genresViewModel.getGenres()
        wait(for: [expectation], timeout: 2)
        XCTAssertFalse(isRefreshDriverTriggered)
        XCTAssertTrue(isErrorDriverTriggered)
    }
}
