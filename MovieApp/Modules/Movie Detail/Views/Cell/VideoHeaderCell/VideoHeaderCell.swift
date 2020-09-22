//
//  VideoHeaderCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoHeaderCell: UITableViewCell, VideoHeaderCellViewProtocol {
    
    @IBOutlet weak var youtubeView: YTPlayerView!
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewLoadingContainer: UIView!
    
    var presenter: VideoHeaderCellPresenterProtocol? {
        didSet {
            if oldValue != nil {
                return
            }
            
            presenter?.getVideo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewLoadingContainer.layer.cornerRadius = 8
        viewLoadingContainer.isHidden = false
        activityIndicator.startAnimating()
        buttonPlay.isHidden = true
        buttonPlay.layer.cornerRadius = 8
        youtubeView.isHidden = true
        youtubeView.delegate = self
        // Initialization code
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        youtubeView.playVideo()
        viewLoadingContainer.isHidden = false
        activityIndicator.startAnimating()
    }
    
    // MARK: Presenter delegate
    func loadVideo(videoId: String) {
        youtubeView.load(withVideoId: videoId)
    }
    
    func hidePlayButton() {
        buttonPlay.isHidden = true
        viewLoadingContainer.isHidden = true
    }
}

extension VideoHeaderCell: YTPlayerViewDelegate {
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            self.viewLoadingContainer.isHidden = true
            self.activityIndicator.stopAnimating()
        default:
            break
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.buttonPlay.isHidden = false
        self.viewLoadingContainer.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
