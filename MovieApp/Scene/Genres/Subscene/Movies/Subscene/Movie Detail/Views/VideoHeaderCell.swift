//
//  VideoHeaderCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import RxSwift
import RxCocoa

class VideoHeaderCell: UITableViewCell {
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var youtubeView: YTPlayerView!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieDetailViewModel: MovieDetailViewModel? {
        didSet {
            bindView()
            movieDetailViewModel?.getVideo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        buttonPlay.isHidden = true
        youtubeView.isHidden = true
        youtubeView.delegate = self
        // Initialization code
    }

    private func bindView() {
        movieDetailViewModel?.videoDriver.drive(onNext: { [weak self] (video) in
            guard let videoId = video?.key else {
                return
            }
            self?.youtubeView.load(withVideoId: videoId)
        })
        .disposed(by: disposeBag)
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        youtubeView.playVideo()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension VideoHeaderCell: YTPlayerViewDelegate {
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        default:
            break
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.buttonPlay.isHidden = false
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
