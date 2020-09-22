//
//  MoviesRouter.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest
import UIKit

class MoviesRouterTest: XCTestCase {

   var sutRouter: MoviesRouter?
    
    override func setUp() {
        sutRouter = MoviesRouter()
        super.setUp()
    }

    override func tearDown() {
        sutRouter = nil
        super.tearDown()
    }
    
    func testCreateModule() {
        let dummyWindow = UIWindow()
        let vc = MoviesRouter.createModule(with: Genre(id: 1, name: "dummy"))
        let navigationController = UINavigationController()
        dummyWindow.rootViewController = navigationController
        dummyWindow.makeKeyAndVisible()
        navigationController.pushViewController(vc, animated: true)
        XCTAssertTrue(navigationController.topViewController!.isKind(of: MoviesViewController.self))
    }

}
