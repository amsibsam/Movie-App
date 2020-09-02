//
//  MovieDetailCoordinator.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailNavigator {
    
}

final class MovieDetailCoordinator: Coordinator {
    typealias NavigationMethod = UINavigationController
    var navigationMethod: UINavigationController
    private var movie: Movie?
    
    init(navigationMethod: UINavigationController) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        guard let movie = self.movie else {
            print("need to pass movieId")
            return
        }
        
        let viewModel = MovieDetailViewModel(movie: movie, navigator: self, interactor: MovieDetailInteractorImpl())
        let viewController = MovieDetailViewController(viewModel: viewModel)
        self.navigationMethod.present(viewController, animated: true, completion: nil)
    }
    
    func start(with movie: Movie) {
        self.movie = movie
        start()
    }
}

extension MovieDetailCoordinator: MovieDetailNavigator {
    
}
