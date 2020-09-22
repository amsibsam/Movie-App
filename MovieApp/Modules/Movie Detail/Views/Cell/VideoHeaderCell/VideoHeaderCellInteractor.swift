//
//  VideoHeaderCellInteractor.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import Moya

class VideoHeaderCellInteractor: VideoHeaderCellInteractorInputProtocol {

    var networkService: NetworkService? = NetworkServiceImpl()
    weak var presenter: VideoHeaderCellInteractorOutputProtocol?
    
    func getViedeo(movieId id: Int) {
        networkService?.request(service: .movieVideo(movieId: id)) { [weak self] (result: Result<VideoResponse, MoyaError>) in
            switch result {
            case .failure(let error):
                self?.presenter?.onGetVideoFailed(errorMessage: error.localizedDescription)
            case .success(let videoResponse):
                guard let trailerYoutube = videoResponse.results?.filter({ $0.type == "Trailer" && $0.site == "YouTube" }).first?.key else {
                    self?.presenter?.onGetVideoFailed(errorMessage: "no Trailer on YouTube site")
                    return
                }
                
                self?.presenter?.onGetVideoSucceed(videoId: trailerYoutube)
            }
        }
    }
}
