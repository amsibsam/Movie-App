//
//  VMoviesRouter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MoviesRouter: MoviesWireframeProtocol {
    
    weak var viewController: UIViewController?

    static func createModule(with genre: Genre) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MoviesViewController()
        let interactor = MoviesInteractor()
        let router = MoviesRouter()
        let presenter = MoviesPresenter(genre: genre, interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func openMovieDetail(movie: Movie) {
        let movieDetailViewController = MovieDetailRouter.createModule(withMovie: movie)
        viewController?.navigationController?.present(movieDetailViewController, animated: true, completion: nil)
    }
    
    func showError(errorMessage: String) {
        guard let viewController = self.viewController else {
            return
        }
        
        UIAlertController.showAlert(in: viewController, withTitle: "Error", andMessage: errorMessage)
    }
}
