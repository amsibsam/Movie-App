//
//  GenresViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class GenresViewController: UIViewController, GenresViewProtocol {
    var presenter: GenresPresenterProtocol?
    
    @IBOutlet weak var tableViewGenre: UITableView!
    
    init() {
        super.init(nibName: "GenresViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getGenres()
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
    
    private func setupUI() {
        tableViewGenre.delegate = self
        tableViewGenre.dataSource = self
        tableViewGenre.register(UINib(nibName: "GenreCell", bundle: Bundle(for: GenresViewController.self)), forCellReuseIdentifier: "GenreCell")
    }
    
    // MARK: Presenter delegate
    func reloadTableView() {
        self.tableViewGenre.reloadData()
    }
}

extension GenresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 262
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.genres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = self.presenter else {
            return UITableViewCell()
        }
        
        let cell = GenreCellRouter.createModule(with: presenter.genres[indexPath.row], viewController: self, tableView: tableView)
        
        return cell
    }
    
}

extension GenresViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
