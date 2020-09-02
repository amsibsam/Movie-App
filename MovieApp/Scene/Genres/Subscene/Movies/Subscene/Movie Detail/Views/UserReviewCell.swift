//
//  UserReviewCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class UserReviewCell: UITableViewCell {
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var textViewContent: UITextView!
    
    var userReview: UserReview? {
        didSet {
            bindView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindView() {
        guard let userReview = userReview else {
            return
        }
        
        labelAuthor.text = userReview.author
        labelContent.text = userReview.content
        textViewContent.text = userReview.content
    }
    
}
