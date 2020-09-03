//
//  MovieDetailCoordinatorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieDetailCoordinatorTest: XCTestCase {
    var movieDetailCoordinator: MovieDetailCoordinator!
    
    func testInit() throws {
        let dummyNavigationController = UINavigationController(rootViewController: UIViewController())
        movieDetailCoordinator = MovieDetailCoordinator(navigationMethod: dummyNavigationController)
        
        XCTAssertNotNil(movieDetailCoordinator)
    }
    
    func testStartWithoutMovie() throws {
        let dummyNavigationController = UINavigationController(rootViewController: UIViewController())
        movieDetailCoordinator = MovieDetailCoordinator(navigationMethod: dummyNavigationController)
        
        movieDetailCoordinator.start()
        XCTAssertNil(dummyNavigationController.presentedViewController)
    }
    
    func testStartWithMovie() throws {
        let window = UIWindow()
        let dummyNavigationController = UINavigationController(rootViewController: UIViewController())
        window.rootViewController = dummyNavigationController
        window.makeKeyAndVisible()
        movieDetailCoordinator = MovieDetailCoordinator(navigationMethod: dummyNavigationController)
        movieDetailCoordinator.start(with: Movie.generateDummyMovie())
        let displayedViewController = dummyNavigationController.topViewController?.presentedViewController
        XCTAssertNotNil(displayedViewController)
        XCTAssert(displayedViewController!.isKind(of: MovieDetailViewController.self))
    }
}
