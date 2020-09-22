//
//  VideoHeaderCellInteractorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import Moya

class VideoHeaderCellInteractorTest: XCTestCase {
    var sutInteractor: VideoHeaderCellInteractor?
    var mockPresenter: VideoHeaderCellPresenterMock?
    var networkServiceMock: NetworkServiceMock?
    
    override func setUp() {
        mockPresenter = VideoHeaderCellPresenterMock()
        networkServiceMock = NetworkServiceMock()
        sutInteractor = VideoHeaderCellInteractor()
        sutInteractor?.presenter = mockPresenter
        sutInteractor?.networkService = networkServiceMock
        super.setUp()
    }
    
    override func tearDown() {
        sutInteractor = nil
        mockPresenter = nil
        networkServiceMock = nil
        super.tearDown()
    }
    
    func testGetVideoSucceed() {
        networkServiceMock?.isSuccess = true
        let mockVideo = Video.generateDummyVideo()
        networkServiceMock?.successResponse = VideoResponse(id: 1, results: [mockVideo])
        sutInteractor?.getViedeo(movieId: 1)
        XCTAssertTrue(mockPresenter!.isOnGetVideoSucceed)
        XCTAssertFalse(mockPresenter!.isOnGetVideoFailed)
        XCTAssertEqual(mockPresenter!.videoId, mockVideo.key)
    }
    
    func testGetVideoErrorNonYouTube() {
        networkServiceMock?.isSuccess = true
        let mockVideo = Video.generateDummyVideoNonYoutube()
        networkServiceMock?.successResponse = VideoResponse(id: 1, results: [mockVideo])
        sutInteractor?.getViedeo(movieId: 1)
        XCTAssertFalse(mockPresenter!.isOnGetVideoSucceed)
        XCTAssertTrue(mockPresenter!.isOnGetVideoFailed)
        XCTAssertEqual(mockPresenter!.errorMessage, "no Trailer on YouTube site")
    }
    
    func testGetVideoFailed() {
        networkServiceMock?.isSuccess = false
        let mockVideo = Video.generateDummyVideo()
        let errorResponse = MoyaError.requestMapping("Error")
        networkServiceMock?.successResponse = VideoResponse(id: 1, results: [mockVideo])
        networkServiceMock?.errorResponse = errorResponse
        sutInteractor?.getViedeo(movieId: 1)
        XCTAssertFalse(mockPresenter!.isOnGetVideoSucceed)
        XCTAssertTrue(mockPresenter!.isOnGetVideoFailed)
        XCTAssertEqual(mockPresenter!.errorMessage, errorResponse.localizedDescription)
    }
}

class VideoHeaderCellPresenterMock: VideoHeaderCellInteractorOutputProtocol {
    var isOnGetVideoSucceed: Bool = false
    var isOnGetVideoFailed: Bool = false
    var errorMessage: String = ""
    var videoId: String = ""
    
    func onGetVideoSucceed(videoId: String) {
        self.videoId = videoId
        isOnGetVideoSucceed = true
    }
    
    func onGetVideoFailed(errorMessage: String) {
        self.errorMessage = errorMessage
        isOnGetVideoFailed = true
    }
    
    
}
