//
//  GenresRouterTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class GenresRouterTest: XCTestCase {
    var sutRouter: GenresRouter?
    
    override func setUp() {
        sutRouter = GenresRouter()
        super.setUp()
    }

    override func tearDown() {
        sutRouter = nil
        super.tearDown()
    }
    
    func testCreateModule() {
        let vc = GenresRouter.createModule()
        let navigationController = UINavigationController()
        navigationController.pushViewController(vc, animated: true)
        XCTAssertTrue(navigationController.topViewController!.isKind(of: GenresViewController.self))
    }
}
