//
//  MovieRowCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import SDWebImage

class MovieRowCell: UITableViewCell, MovieRowCellViewProtocol {
        
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelVote: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    var presenter: MovieRowCellPresenterProtocol? {
        didSet {
            presenter?.getMovie()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewGradient.setGradient(startColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), endColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), horizontalRadius: 0.8)
        imageViewPoster.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Presenter delegate
    func showMovie(movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        labelTitle.text = movie.title
        labelVote.text = "\(movie.voteAverage ?? 0)"
        labelReleaseDate.text = movie.releaseDate ?? ""
        
        if let backdropUrl = movie.posterMedium {
            imageViewPoster.sd_setImage(with: backdropUrl)
        }
    }
    
}
