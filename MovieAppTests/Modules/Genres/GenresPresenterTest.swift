//
//  GenresPresenterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class GenresPresenterTest: XCTestCase {
    
    var sutPresenter: GenresPresenter?
    var genresViewMock: GenresViewMock?
    var genresInteractorMock: GenresInteractorMock?
    var genresRouterMock: GenresRouterMock?
    
    override func setUp() {
        genresViewMock = GenresViewMock()
        genresInteractorMock = GenresInteractorMock()
        genresRouterMock = GenresRouterMock()
        sutPresenter = GenresPresenter(interface: genresViewMock!, interactor: genresInteractorMock, router: genresRouterMock!)
        genresInteractorMock?.presenter = sutPresenter
        genresViewMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        genresViewMock = nil
        genresInteractorMock = nil
        genresRouterMock = nil
        super.tearDown()
    }
    
    func testGetGenresSucceed() {
        genresInteractorMock?.isSuccess = true
        sutPresenter?.getGenres()
        XCTAssertTrue(genresViewMock!.isReloadTableViewCalled)
        XCTAssertFalse(sutPresenter!.genres.isEmpty)
    }
    
    func testGetGenresFailed() {
        genresInteractorMock?.isSuccess = false
        sutPresenter?.getGenres()
        XCTAssertFalse(genresViewMock!.isReloadTableViewCalled)
        XCTAssertTrue(sutPresenter!.genres.isEmpty)
        XCTAssertTrue(genresRouterMock!.isShowErrorCalled)
    }
}

class GenresViewMock: GenresViewProtocol {
    var presenter: GenresPresenterProtocol?
    var isReloadTableViewCalled: Bool = false
    
    func reloadTableView() {
        isReloadTableViewCalled = true
    }
}

class GenresInteractorMock: GenresInteractorInputProtocol {
    var isSuccess: Bool = true
    
    var networkService: NetworkService?
    
    var presenter: GenresInteractorOutputProtocol?
    
    func getGenres() {
        if isSuccess {
            presenter?.onGetGenresSucceed(genres: [Genre(id: 1, name: "dummy")])
        } else {
            presenter?.onGetGenresFailed(errorMessage: "Error")
        }
    }
}

class GenresRouterMock: GenresWireframeProtocol {
    var isShowErrorCalled: Bool = false
    
    func showError(errorMessage: String) {
        isShowErrorCalled = true
    }
}
