//
//  Coordinator.swift
//  CatChat
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

protocol Coordinator {
    associatedtype NavigationMethod
    
    var navigationMethod: NavigationMethod { get }
    
    init(navigationMethod: NavigationMethod)
    
    func start()
}

