//
//  MovieInfoCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieInfoCell: UITableViewCell {
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelVote: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    var movieDetailViewModel: MovieDetailViewModel? {
        didSet {
            bindView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelStatus.layer.cornerRadius = 8
        labelStatus.clipsToBounds = true
        // Initialization code
    }

    private func bindView() {
        movieDetailViewModel?.movieDriver.drive(onNext: { [weak self] (movie) in
            self?.labelTitle.text = movie?.title
            self?.labelReleaseDate.text = movie?.releaseDate
            self?.labelVote.text = "\(movie?.voteAverage ?? 0)"
            self?.labelOverview.text = movie?.overview
            self?.labelStatus.text = movie?.status
        })
        .disposed(by: disposeBag)
    }
}
