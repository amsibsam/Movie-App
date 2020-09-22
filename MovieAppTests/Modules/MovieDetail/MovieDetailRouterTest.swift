//
//  MoviesRouter.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieDetailRouterTest: XCTestCase {

   var sutRouter: MovieDetailRouter?
    
    override func setUp() {
        sutRouter = MovieDetailRouter()
        super.setUp()
    }

    override func tearDown() {
        sutRouter = nil
        super.tearDown()
    }
    
    func testCreateModule() {
        let dummyWindow = UIWindow()
        let vc = MovieDetailRouter.createModule(withMovie: Movie.generateDummyMovieWithPoster())
        let navigationController = UINavigationController()
        dummyWindow.rootViewController = navigationController
        dummyWindow.makeKeyAndVisible()
        navigationController.pushViewController(vc, animated: true)
        XCTAssertTrue(navigationController.topViewController!.isKind(of: MovieDetailViewController.self))
    }

}
