//
//  GenresInteractorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import Moya

class GenresInteractorTest: XCTestCase {
    
    var sutInteractor: GenresInteractor?
    var mockPresenter: GenresInteractorPresenterMock?
    var networkServiceMock: NetworkServiceMock?
    
    override func setUp() {
        sutInteractor = GenresInteractor()
        mockPresenter = GenresInteractorPresenterMock()
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
    
    func testGetGenresSucceed() {
        networkServiceMock?.isSuccess = true
        let genreResponse = GenreResponse(genres: [Genre(id: 1, name: "dummy")])
        networkServiceMock?.successResponse = genreResponse
        sutInteractor?.getGenres()
        XCTAssertTrue(mockPresenter!.isOnGetGenresSucceedCalled)
        XCTAssertFalse(mockPresenter!.isOnGetGenresFailedCalled)
        XCTAssertTrue(genreResponse.genres.count == mockPresenter?.genres.count)
    }
    
    func testGetGenresFailed() {
        networkServiceMock?.isSuccess = false
        let errorResponse = MoyaError.requestMapping("error")
        networkServiceMock?.errorResponse = errorResponse
        sutInteractor?.getGenres()
        XCTAssertFalse(mockPresenter!.isOnGetGenresSucceedCalled)
        XCTAssertTrue(mockPresenter!.isOnGetGenresFailedCalled)
        XCTAssertTrue(errorResponse.localizedDescription == mockPresenter?.errorMessage)
    }
}

class GenresInteractorPresenterMock: GenresInteractorOutputProtocol {
    var isOnGetGenresSucceedCalled: Bool = false
    var isOnGetGenresFailedCalled: Bool = false
    var genres: [Genre] = []
    var errorMessage: String = ""
    
    func onGetGenresSucceed(genres: [Genre]) {
        self.genres = genres
        isOnGetGenresSucceedCalled = true
    }
    
    func onGetGenresFailed(errorMessage: String) {
        self.errorMessage = errorMessage
        isOnGetGenresFailedCalled = true
    }
}
