//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, MoviesViewProtocol {
        
    var presenter: MoviesPresenterProtocol?
    private var currentPage: Int = 1
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewMovies: UITableView!
    
    init() {
        super.init(nibName: "MoviesViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getTitle()
        presenter?.getMovies(page: currentPage)
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.register(UINib(nibName: "MovieRowCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieRowCell")
    }
    
    // MARK: Presenter delegate
    func reloadTableView() {
        tableViewMovies.reloadData()
    }
    
    func showTitle(title: String) {
        self.title = title
    }
    
    func showLoading() {
        activityIndicator.startLoading(true)
    }
    
    func stopLoading() {
        activityIndicator.startLoading(false)
    }
    
}

extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieRowCellRouter.createModule(with: self.presenter?.movies[indexPath.row], viewController: self, tableView: tableView)
        
        if indexPath.row == (self.presenter?.movies.count ?? 0) - 3 {
            print("::loadmore \(indexPath.row) \((self.presenter?.movies.count ?? 0) - 3)")
            currentPage += 1
            self.presenter?.getMovies(page: currentPage)
        }
        
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.openMovieDetail(atIndex: indexPath.row)
    }
}
