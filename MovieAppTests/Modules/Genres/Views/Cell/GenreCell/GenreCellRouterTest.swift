//
//  MoviesRouter.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 22/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class GenreCellRouterTest: XCTestCase {

   var sutRouter: GenreCellRouter?
    
    override func setUp() {
        sutRouter = GenreCellRouter()
        super.setUp()
    }

    override func tearDown() {
        sutRouter = nil
        super.tearDown()
    }
    
    func testCreateModule() {
        let tableView = UITableView()
        tableView.register(UINib(nibName: "GenreCell", bundle: Bundle(for: GenresViewController.self)), forCellReuseIdentifier: "GenreCell")
        let cell = GenreCellRouter.createModule(with: Genre(id: 1, name: "dummy"), viewController: UIViewController(), tableView: tableView)
        XCTAssertTrue(cell.isKind(of: GenreCell.self))
    }

}
