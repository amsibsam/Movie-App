//
//  ActivityIndicator+Interaction.swift
//  MovieApp
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func startLoading(_ isStart: Bool) {
        if isStart {
            self.isHidden = false
            self.startAnimating()
        } else {
            self.isHidden = true
            self.stopAnimating()
        }
    }
}
