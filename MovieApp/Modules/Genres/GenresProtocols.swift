//
//  VGenresProtocols.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol GenresWireframeProtocol: class {
    func showError(errorMessage: String)
}

//MARK: Presenter -
protocol GenresPresenterProtocol: class {
    var interactor: GenresInteractorInputProtocol? { get set }
    var genres: [Genre] { get }
    
    /* ViewController -> Presenter  */
    func getGenres()
}

//MARK: Interactor -
protocol GenresInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func onGetGenresSucceed(genres: [Genre])
    func onGetGenresFailed(errorMessage: String)
}

protocol GenresInteractorInputProtocol: class {
    var networkService: NetworkService? { get set }
    var presenter: GenresInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
    func getGenres()
}

//MARK: View -
protocol GenresViewProtocol: class {
    
    var presenter: GenresPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func reloadTableView()
}
