//
//  UIView+Gradient.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

enum GradientDirection {
    case vertical
    case horizontal
}

extension UIView {
    func setGradient(startColor: UIColor, endColor: UIColor, verticalRadius: CGFloat = 0.45, horizontalRadius: CGFloat = 1.5, direction: GradientDirection = .horizontal) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        if direction == .horizontal {
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: horizontalRadius, y: 1.0)
        } else {
            gradient.startPoint = CGPoint(x: 1.0, y: verticalRadius)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)

        self.layer.insertSublayer(gradient, at: 0)
    }
}
