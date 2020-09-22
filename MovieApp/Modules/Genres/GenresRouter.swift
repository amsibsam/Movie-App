//
//  VGenresRouter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class GenresRouter: GenresWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = GenresViewController()
        let interactor = GenresInteractor()
        let router = GenresRouter()
        let presenter = GenresPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func showError(errorMessage: String) {
        guard let viewController = self.viewController else {
            return
        }
        
        UIAlertController.showAlert(in: viewController, withTitle: "Error", andMessage: errorMessage)
    }
    
}
