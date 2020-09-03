//
//  GenresCoordinatorTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class GenresCoordinatorTest: XCTestCase {
    private var genreCoordinator: GenresCoordinator!
    private var dummyWindow: UIWindow!

    override func setUpWithError() throws {
        dummyWindow = UIWindow()
        genreCoordinator = GenresCoordinator(navigationMethod: dummyWindow)
    }

    override func tearDownWithError() throws {
        dummyWindow = nil
        genreCoordinator = nil
    }

    func testStart() throws {
        genreCoordinator.start()
        
        XCTAssertNotNil(dummyWindow.rootViewController)
        XCTAssert(dummyWindow.rootViewController!.isKind(of: UINavigationController.self))
        
        let rootNavigation = dummyWindow.rootViewController as! UINavigationController
        let displayedViewController = rootNavigation.viewControllers.first
        XCTAssertNotNil(displayedViewController)
        XCTAssert(displayedViewController!.isKind(of: GenresViewController.self))
    }
    
    func testOpenMovie() throws {
        genreCoordinator.start()
        genreCoordinator.openMovie(Movie.generateDummyMovie())
        
        let rootNavigation = dummyWindow.rootViewController as! UINavigationController
        let displayedViewController = rootNavigation.viewControllers.last?.presentedViewController
        XCTAssertNotNil(displayedViewController)
        XCTAssert(displayedViewController!.isKind(of: MovieDetailViewController.self))
    }
    
    
    func testOpenMovies() throws {
        genreCoordinator.start()
        genreCoordinator.openMovies(withGenre: Genre(id: 1, name: "dummy"))
        
        let rootNavigation = dummyWindow.rootViewController as! UINavigationController
        
        var displayedViewController: UIViewController?
        let expectation = XCTestExpectation(description: "testOpenMovies")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            displayedViewController = rootNavigation.topViewController
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(displayedViewController)
        XCTAssert(displayedViewController!.isKind(of: MoviesViewController.self))
    }
    
}
