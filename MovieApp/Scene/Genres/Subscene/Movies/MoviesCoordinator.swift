//
//  MoviesCoordinator.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesNavigator {
    func openMovieDetail(with movie: Movie)
}

final class MoviesCoordinator: Coordinator {
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    private var genreId: Int?
    
    init(navigationMethod: UINavigationController) {
        self.navigationMethod  = navigationMethod
    }
    
    func start() {
        guard let genreId = self.genreId else {
            print("need to pass genre id")
            return
        }
        let viewModel = MoviesViewModel(genreId: genreId, navigator: self, interactor: MoviesInteractorImpl())
        let viewController = MoviesViewController(viewModel: viewModel)
        self.navigationMethod.pushViewController(viewController, animated: true)
    }
    
    func start(withGenreId id: Int) {
        self.genreId = id
        self.start()
    }
}

extension MoviesCoordinator: MoviesNavigator {
    func openMovieDetail(with movie: Movie) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationMethod: self.navigationMethod)
        movieDetailCoordinator.start(with: movie)
    }
}
