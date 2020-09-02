//
//  GenresCoordinator.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

protocol GenresNavigator {
    func openMovies(withGenre genre: Genre)
    func openMovie(_ movie: Movie)
}

final class GenresCoordinator: Coordinator {
    typealias NavigationMethod = UIWindow
    var navigationMethod: UIWindow
    
    required init(navigationMethod: UIWindow) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        let viewModel = GenresViewModel(navigator: self, interactor: GenresInteractorImpl())
        let viewController = GenresViewController(viewModel: viewModel)
        self.navigationMethod.rootViewController = UINavigationController(rootViewController: viewController)
        self.navigationMethod.makeKeyAndVisible()
    }
}

extension GenresCoordinator: GenresNavigator {
    func openMovies(withGenre genre: Genre) {
        guard let navigationController = self.navigationMethod.rootViewController as? UINavigationController else {
            return
        }
        
        let moviesCoordinator = MoviesCoordinator(navigationMethod: navigationController)
        moviesCoordinator.start(withGenre: genre)
    }
    
    func openMovie(_ movie: Movie) {
        guard let navigationController = self.navigationMethod.rootViewController as? UINavigationController else {
            return
        }
        
        let movieDetailCoordinator = MovieDetailCoordinator(navigationMethod: navigationController)
        movieDetailCoordinator.start(with: movie)
    }
}
