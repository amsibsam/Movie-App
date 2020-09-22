//
//  MovieInfoCellRouter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MovieInfoCellRouter: MovieInfoCellWireframeProtocol {

    static func createModule(with movie: Movie?, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell") as! MovieInfoCell
        let interactor = MovieInfoCellInteractor()
        let router = MovieInfoCellRouter()
        let presenter = MovieInfoCellPresenter(movie: movie, interface: cell, interactor: interactor, router: router)

        cell.presenter = presenter
        interactor.presenter = presenter

        return cell
    }
}
