//
//  VGenreCellRouter.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

class GenreCellRouter: GenreCellWireframeProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(with genre: Genre, viewController: UIViewController, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell") as! GenreCell
        let interactor = GenreCellInteractor()
        let router = GenreCellRouter()
        let cellPresenter = GenreCellPresenter(genre: genre, interface: cell, interactor: interactor, router: router)
        
        cell.presenter = cellPresenter
        interactor.presenter = cellPresenter
        router.viewController = viewController
        
        return cell
    }
    
    func openMovies(withGenre genre: Genre) {
        let moviesViewController = MoviesRouter.createModule(with: genre)
        
        viewController?.navigationController?.pushViewController(moviesViewController, animated: true)
    }
    
    func openMovie(movie: Movie) {
        let movieDetailViewController = MovieDetailRouter.createModule(withMovie: movie)
        
        viewController?.navigationController?.present(movieDetailViewController, animated: true, completion: nil)
    }
}
