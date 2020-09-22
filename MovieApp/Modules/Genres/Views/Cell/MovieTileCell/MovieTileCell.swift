//
//  MovieTileCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTileCell: UICollectionViewCell, MovieTileCellViewProtocol {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelVote: UILabel!
    @IBOutlet var imageViewPoster: UIImageView!
    
    var presenter: MovieTileCellPresenterProtocol? {
        didSet {
            presenter?.getMovie()
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
        imageViewPoster.setGradient(startColor: #colorLiteral(red: 0.05983794481, green: 0.05985610187, blue: 0.05983554572, alpha: 0.9007207306), endColor: #colorLiteral(red: 0.1686967611, green: 0.1687321961, blue: 0.1686921418, alpha: 0), verticalRadius: 0.7, direction: .vertical)
        
    }
    
    // MARK: Presenter delegate
    func showMovie(movie: Movie) {
        labelTitle.text = movie.title
        labelVote.text = "\(movie.voteAverage ?? 0)"
        if let posterUrl = movie.posterMedium {
            imageViewPoster.sd_setImage(with: posterUrl)
        }
    }
    
}
