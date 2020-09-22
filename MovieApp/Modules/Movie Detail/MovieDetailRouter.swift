//
//  VMovieDetailRouter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MovieDetailRouter: MovieDetailWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(withMovie movie: Movie) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MovieDetailViewController()
        let router = MovieDetailRouter()
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter(movie: movie, interface: view, router: router, interactor: interactor)
        
        router.viewController = view
        interactor.presenter = presenter
        view.presenter = presenter

        return view
    }
}
