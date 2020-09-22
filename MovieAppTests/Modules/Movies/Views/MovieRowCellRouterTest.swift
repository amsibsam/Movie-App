//
//  MoviesRouter.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class MovieRowCellRouterTest: XCTestCase {

   var sutRouter: MovieRowCellRouter?
    
    override func setUp() {
        sutRouter = MovieRowCellRouter()
        super.setUp()
    }

    override func tearDown() {
        sutRouter = nil
        super.tearDown()
    }
    
    func testCreateModule() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "MovieRowCell", bundle: Bundle(for: MoviesViewController.self)), forCellReuseIdentifier: "MovieRowCell")
        let cell = MovieRowCellRouter.createModule(with: Movie.generateDummyMovieWithPoster(), viewController: UIViewController(), tableView: tableView)
        XCTAssertTrue(cell.isKind(of: MovieRowCell.self))
    }

}
