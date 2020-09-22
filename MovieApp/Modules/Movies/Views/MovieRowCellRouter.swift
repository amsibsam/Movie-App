//
//  MovieRowCellRouter.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

class MovieRowCellRouter: MovieRowCellWireframeProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(with movie: Movie?, viewController: UIViewController, tableView: UITableView) -> UITableViewCell {
        // Change to get view from storyboard if not using progammatic UI
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRowCell") as! MovieRowCell
        let router = MovieRowCellRouter()
        let cellPresenter = MovieRowCellPresenter(movie: movie, interface: cell, router: router)
        
        cell.presenter = cellPresenter
        router.viewController = viewController
        
        return cell
    }
}
