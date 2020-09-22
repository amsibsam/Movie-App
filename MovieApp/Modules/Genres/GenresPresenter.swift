//
//  VGenresPresenter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class GenresPresenter: GenresPresenterProtocol, GenresInteractorOutputProtocol {
    
    var genres: [Genre] {
        get {
            return _genres
        }
    }
    var interactor: GenresInteractorInputProtocol?
    
    private var _genres: [Genre] = []
    weak private var view: GenresViewProtocol?
    private let router: GenresWireframeProtocol
    
    
    init(interface: GenresViewProtocol, interactor: GenresInteractorInputProtocol?, router: GenresWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getGenres() {
        interactor?.getGenres()
    }
    
    // MARK: Interactor delegate
    func onGetGenresSucceed(genres: [Genre]) {
        _genres = genres
        Thread.runOnMainThread { [weak self] in
            self?.view?.reloadTableView()
        }
    }
    
    func onGetGenresFailed(errorMessage: String) {
        Thread.runOnMainThread { [weak self] in
            self?.router.showError(errorMessage: errorMessage)
        }
    }
    
}
