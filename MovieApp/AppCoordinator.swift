//
//  AppCoordinator.swift
//  CatChat
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

protocol AppCoordinatorNavigator {
    func showGenres()
}

class AppCoordinator: Coordinator {
    typealias NavigationMethod = UIWindow
    var navigationMethod: NavigationMethod
    
    required init(navigationMethod: NavigationMethod) {
        self.navigationMethod = navigationMethod
    }
    
    func start() {
        // setup root viewController state
        self.setupRootState()
        // setup IQKeyboard
        self.setupIQKeyboard()
    }
    
    private func setupRootState() {
        // implement logic to determine root screen
        self.showGenres()
    }
    
    private func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
}

extension AppCoordinator: AppCoordinatorNavigator {
    func showGenres() {
        let genresCoordinator = GenresCoordinator(navigationMethod: self.navigationMethod)
        genresCoordinator.start()
    }
}
