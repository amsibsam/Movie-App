//
//  MovieTileCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class MovieTileCell: UICollectionViewCell {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelVote: UILabel!
    @IBOutlet var imageViewPoster: UIImageView!
    
    var viewModel: MovieTileCellViewModel? {
        didSet {
            bindView()
            viewModel?.getMovie()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewPoster.image = nil
        imageViewPoster.backgroundColor = .lightGray
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewPoster.backgroundColor = .lightGray
        imageViewPoster.layer.cornerRadius = 8
        imageViewPoster.clipsToBounds = true
        imageViewPoster.contentMode = .scaleAspectFill
        // Initialization code
    }
    
    private func bindView() {
        viewModel?.movieDriver.drive(onNext: { [weak self] (movie) in
            guard let movie = movie else {
                return
            }
            
            self?.labelTitle.text = movie.title
            self?.labelVote.text = "\(movie.voteAverage ?? 0)"
            if let posterUrl = movie.posterMedium {
                self?.imageViewPoster.sd_setImage(with: posterUrl)
            }
        })
        .disposed(by: disposeBag)
    }
}
