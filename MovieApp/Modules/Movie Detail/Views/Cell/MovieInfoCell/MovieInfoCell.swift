//
//  MovieInfoCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MovieInfoCell: UITableViewCell, MovieInfoCellViewProtocol {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelVote: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    
    var presenter: MovieInfoCellPresenterProtocol? {
        didSet {
            presenter?.getMovie()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        labelStatus.layer.cornerRadius = 8
        labelStatus.clipsToBounds = true
        // Initialization code
    }
    
    // MARK: Presenter delegate
    func showMovie(movie: Movie) {
        self.labelTitle.text = movie.title
        self.labelReleaseDate.text = movie.releaseDate
        self.labelVote.text = "\(movie.voteAverage ?? 0)"
        self.labelOverview.text = movie.overview
        self.labelStatus.text = movie.status
    }
}
