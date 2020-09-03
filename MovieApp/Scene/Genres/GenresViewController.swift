//
//  GenresViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GenresViewController: UIViewController {
    private let viewModel: GenresViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var tableViewGenre: UITableView!
    
    init(viewModel: GenresViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "GenresViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getGenres()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func bindView() {
        viewModel.refreshDriver.drive(onNext: { [weak self] (_) in
            self?.tableViewGenre.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel.errorDriver.drive(onNext: { [weak self] (errorMessage) in
            guard let self = self else {
                return
            }
            UIAlertController.showAlert(in: self, withTitle: "Error", andMessage: errorMessage)
        })
        .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        setupTableView()
        bindView()
    }
    
    private func setupTableView() {
        tableViewGenre.delegate = self
        tableViewGenre.dataSource = self
        tableViewGenre.register(UINib(nibName: "GenreCell", bundle: Bundle(for: GenresViewController.self)), forCellReuseIdentifier: "GenreCell")
    }
}

extension GenresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        cell.viewModel = GenreCellViewModel(cellIndex: indexPath.row, genresViewModel: viewModel, interactor: GenresInteractorImpl())
        
        return cell
    }
    
    
}

extension GenresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
