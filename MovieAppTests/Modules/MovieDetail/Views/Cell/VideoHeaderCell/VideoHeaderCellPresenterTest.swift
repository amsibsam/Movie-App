//
//  VideoHeaderCellPresenterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class VideoHeaderCellPresenterTest: XCTestCase {
    var sutPresenter: VideoHeaderCellPresenter?
    var mockMovie: Movie = Movie.generateDummyMovie()
    var viewMock: VideoHeaderCellViewMock?
    var interactorMock: VideoHeaderCellInteractorMock?
    var routerMock: VideoHeaderCellRouterMock?

    override func setUp() {
        viewMock = VideoHeaderCellViewMock()
        interactorMock = VideoHeaderCellInteractorMock()
        routerMock = VideoHeaderCellRouterMock()
        sutPresenter = VideoHeaderCellPresenter(movie: mockMovie, interface: viewMock!, interactor: interactorMock!, router: routerMock!)
        interactorMock?.presenter = sutPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sutPresenter = nil
        interactorMock = nil
        routerMock = nil
        viewMock = nil
        super.tearDown()
    }
    
    func testGetVideoSucceed() {
        interactorMock?.isSuccess = true
        sutPresenter?.getVideo()
        XCTAssertTrue(viewMock!.isLoadVideoCalled)
        XCTAssertFalse(viewMock!.isHidePlayButtonCalled)
        XCTAssertEqual(viewMock!.videoId, interactorMock!.videoId)
    }
    
    func testGetVideoFailed() {
        interactorMock?.isSuccess = false
        sutPresenter?.getVideo()
        XCTAssertFalse(viewMock!.isLoadVideoCalled)
        XCTAssertTrue(viewMock!.isHidePlayButtonCalled)
    }
}

class VideoHeaderCellViewMock: VideoHeaderCellViewProtocol {
    var isLoadVideoCalled: Bool = false
    var isHidePlayButtonCalled: Bool = false
    var videoId: String = ""
    var presenter: VideoHeaderCellPresenterProtocol?
    
    func loadVideo(videoId: String) {
        self.videoId = videoId
        isLoadVideoCalled = true
    }
    
    func hidePlayButton() {
        isHidePlayButtonCalled = true
    }
}

class VideoHeaderCellInteractorMock: VideoHeaderCellInteractorInputProtocol {
    var isSuccess: Bool = true
    var networkService: NetworkService?
    var videoId: String  = "videoId"
    var errorMessage: String = "error"
    
    var presenter: VideoHeaderCellInteractorOutputProtocol?
    
    func getViedeo(movieId id: Int) {
        if isSuccess {
            presenter?.onGetVideoSucceed(videoId: videoId)
        } else {
            presenter?.onGetVideoFailed(errorMessage: errorMessage)
        }
    }
}

class VideoHeaderCellRouterMock: VideoHeaderCellWireframeProtocol {
    
}
