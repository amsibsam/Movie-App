//
//  UIAlertViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func showAlert(in viewController: UIViewController, withTitle title: String , andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertActionClose = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(alertActionClose)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
