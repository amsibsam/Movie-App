//
//  VideoHeaderCellRouter.swift
//  MovieApp
//
//  Created MTMAC36 on 21/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class VideoHeaderCellRouter: VideoHeaderCellWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(with movie: Movie?, tableView: UITableView) -> UITableViewCell {
        // Change to get view from storyboard if not using progammatic UI
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoHeaderCell") as! VideoHeaderCell
        let interactor = VideoHeaderCellInteractor()
        let router = VideoHeaderCellRouter()
        let presenter = VideoHeaderCellPresenter(movie: movie, interface: cell, interactor: interactor, router: router)

        cell.presenter = presenter
        interactor.presenter = presenter

        return cell
    }
}
