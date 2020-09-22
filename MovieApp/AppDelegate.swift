//
//  AppDelegate.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let genresViewController = GenresRouter.createModule()
        let rootNavigationController = UINavigationController(rootViewController: genresViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        return true
    }


}
