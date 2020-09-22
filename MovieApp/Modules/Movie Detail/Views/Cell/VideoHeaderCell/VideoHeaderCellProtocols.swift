//
//  VideoHeaderCellProtocols.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol VideoHeaderCellWireframeProtocol: class {

}
//MARK: Presenter -
protocol VideoHeaderCellPresenterProtocol: class {

    var interactor: VideoHeaderCellInteractorInputProtocol? { get set }
    
    /* ViewController -> Presenter */
    func getVideo()
}

//MARK: Interactor -
protocol VideoHeaderCellInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onGetVideoSucceed(videoId: String)
    func onGetVideoFailed(errorMessage: String)
}

protocol VideoHeaderCellInteractorInputProtocol: class {

    var networkService: NetworkService? { get set }
    var presenter: VideoHeaderCellInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getViedeo(movieId id: Int)
}

//MARK: View -
protocol VideoHeaderCellViewProtocol: class {

    var presenter: VideoHeaderCellPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func loadVideo(videoId: String)
    
    func hidePlayButton()
}
