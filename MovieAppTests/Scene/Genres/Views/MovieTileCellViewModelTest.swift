//
//  MovieTileViewModelTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

class MovieTileCellViewModelTest: XCTestCase {
    private let disposeBag: DisposeBag = DisposeBag()
    private let dummyMovie: Movie = Movie.generateDummyMovie()

    func testGetMovie() throws {
        let movieTileCellViewModel = MovieTileCellViewModel(movie: dummyMovie)
        var movieResult: Movie?
        
        let expectation = XCTestExpectation(description: "testGetMovie")
        movieTileCellViewModel.movieDriver.drive(onNext: { (movie) in
            movieResult = movie
            expectation.fulfill()
        })
        .disposed(by: disposeBag)
        movieTileCellViewModel.getMovie()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(dummyMovie.id == movieResult?.id)
    }

}
