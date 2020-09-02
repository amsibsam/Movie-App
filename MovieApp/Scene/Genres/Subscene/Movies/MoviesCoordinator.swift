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
    private var genre: Genre?
    
    init(navigationMethod: UINavigationController) {
        self.navigationMethod  = navigationMethod
    }
    
    func start() {
        guard let genre = self.genre else {
            print("need to pass genre")
            return
        }
        let viewModel = MoviesViewModel(genre: genre, navigator: self, interactor: MoviesInteractorImpl())
        let viewController = MoviesViewController(viewModel: viewModel)
        self.navigationMethod.pushViewController(viewController, animated: true)
    }
    
    func start(withGenre genre: Genre) {
        self.genre = genre
        self.start()
    }
}

extension MoviesCoordinator: MoviesNavigator {
    func openMovieDetail(with movie: Movie) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationMethod: self.navigationMethod)
        movieDetailCoordinator.start(with: movie)
    }
}
