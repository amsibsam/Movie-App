//
//  MovieRowCellViewModelTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

class MovieRowCellViewModelTest: XCTestCase {
    private let disposeBag: DisposeBag = DisposeBag()
    private let dummyMovie: Movie = Movie.generateDummyMovie()
    
    func testGetMovie() throws {
        let movieRowCellViewModel = MovieRowCellViewModel(movie: dummyMovie)
        var movieResult: Movie?
        
        let expectation = XCTestExpectation(description: "testGetMovie")
        movieRowCellViewModel.movieDriver.drive(onNext: { (movie) in
            movieResult = movie
            expectation.fulfill()
        })
            .disposed(by: disposeBag)
        movieRowCellViewModel.getMovie()
        
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(dummyMovie.id == movieResult?.id)
    }
}
