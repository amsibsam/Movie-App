//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController {
    private let viewModel: MoviesViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var currentPage: Int = 1
    
    @IBOutlet weak var tableViewMovies: UITableView!
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MoviesViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getMovies(page: currentPage)
    }
    
    private func setupUI() {
        setupTableView()
        bindView()
    }
    
    private func bindView() {
        viewModel.refreshDriver.drive(onNext: { [weak self] (_) in
            self?.tableViewMovies.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel.errorDriver.drive(onNext: { (errorMessage) in
            // TODO: handle error later
            print("::error when get movies \(errorMessage)")
        })
        .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.register(UINib(nibName: "MovieRowCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieRowCell")
    }
    
}

extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRowCell", for: indexPath) as! MovieRowCell
        cell.viewModel = MovieRowCellViewModel(movie: self.viewModel.movies[indexPath.row])
        
        if indexPath.row == self.viewModel.movies.count - 3 {
            currentPage += 1
            self.viewModel.getMovies(page: currentPage)
        }
        
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.openMovieDetail(atIndex: indexPath.row)
    }
}
