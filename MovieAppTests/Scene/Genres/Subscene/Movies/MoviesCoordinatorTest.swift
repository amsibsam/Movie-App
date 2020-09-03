//
//  MoviesCoordinatorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MoviesCoordinatorTest: XCTestCase {
    let dummyNavigationController: UINavigationController = UINavigationController()

    func testInit() throws {
        let moviesCoordinator = MoviesCoordinator(navigationMethod: dummyNavigationController)
        
        XCTAssertNotNil(moviesCoordinator)
    }
    
    func testStartWithoutGenre() throws {
        let moviesCoordinator = MoviesCoordinator(navigationMethod: dummyNavigationController)
        moviesCoordinator.start()
        let displayedViewController = dummyNavigationController.topViewController
        XCTAssertNil(displayedViewController)
    }
    
    func testStartWithGenre() throws {
        let moviesCoordinator = MoviesCoordinator(navigationMethod: dummyNavigationController)
        moviesCoordinator.start(withGenre: Genre(id: 1, name: "dummy"))
        let displayedViewController = dummyNavigationController.topViewController
        XCTAssertNotNil(displayedViewController)
        XCTAssert(displayedViewController!.isKind(of: MoviesViewController.self))
    }

}
