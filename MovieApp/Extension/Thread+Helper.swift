//
//  Thread+Helper.swift
//  MovieApp
//
//  Created by MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

extension Thread {
    static func runOnMainThread(_ mainThreadBlock: @escaping (() -> Void)) {
        if Thread.isMainThread {
            mainThreadBlock()
            return
        }
        
        DispatchQueue.main.async {
            mainThreadBlock()
        }
    }
}
