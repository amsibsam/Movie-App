//
//  VideoHeaderCellPresenter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class VideoHeaderCellPresenter: VideoHeaderCellPresenterProtocol, VideoHeaderCellInteractorOutputProtocol {

    weak private var view: VideoHeaderCellViewProtocol?
    var interactor: VideoHeaderCellInteractorInputProtocol?
    private let router: VideoHeaderCellWireframeProtocol
    private let movie: Movie?

    init(movie: Movie?, interface: VideoHeaderCellViewProtocol, interactor: VideoHeaderCellInteractorInputProtocol?, router: VideoHeaderCellWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
    
    func getVideo() {
        guard let movie = self.movie else {
            return
        }
        interactor?.getViedeo(movieId: movie.id)
    }

    func onGetVideoSucceed(videoId: String) {
        Thread.runOnMainThread { [weak self] in
            self?.view?.loadVideo(videoId: videoId)
        }
    }
    
    func onGetVideoFailed(errorMessage: String) {
        Thread.runOnMainThread { [weak self] in
            self?.view?.hidePlayButton()
        }
    }
}
