//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class MovieDetailViewController: UIViewController {
    private let viewModel: MovieDetailViewModel
    private let disposeBag: DisposeBag = DisposeBag()
    private var currentPage: Int = 1

    @IBOutlet weak var tableViewContent: UITableView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var viewGradient: UIView!
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getMovie()
        viewModel.getUserReviews(page: currentPage)
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        viewGradient.setGradient(startColor: #colorLiteral(red: 0.1323497891, green: 0.1323794127, blue: 0.132345885, alpha: 1), endColor: #colorLiteral(red: 0.16707775, green: 0.1671129167, blue: 0.1670731306, alpha: 0.2552266725), direction: .vertical)
        imageViewPoster.contentMode = .scaleAspectFill
        setupTableView()
        bindView()
    }
    
    private func setupTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.estimatedRowHeight = UITableView.automaticDimension
        tableViewContent.register(UINib(nibName: "VideoHeaderCell", bundle: Bundle.main), forCellReuseIdentifier: "VideoHeaderCell")
        tableViewContent.register(UINib(nibName: "MovieInfoCell", bundle: Bundle.main), forCellReuseIdentifier: "MovieInfoCell")
        tableViewContent.register(UINib(nibName: "UserReviewCell", bundle: Bundle.main), forCellReuseIdentifier: "UserReviewCell")
    }
    
    private func bindView() {
        viewModel.movieDriver.drive(onNext: { [weak self] (movie) in
            self?.tableViewContent.reloadData()
            if let posterUrl = movie?.posterMedium {
                self?.imageViewPoster.sd_setImage(with: posterUrl)
            }
        })
        .disposed(by: disposeBag)
        
        viewModel.reviewRefreshDriver.drive(onNext: { [weak self] (_) in
            self?.tableViewContent.reloadSections(IndexSet(integer: 2), with: .none)
        })
        .disposed(by: disposeBag)
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height * 0.3
        }
        return UITableView.automaticDimension
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 {
            return 1
        }
        
        return self.viewModel.userReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoHeaderCell", for: indexPath) as! VideoHeaderCell
            cell.movieDetailViewModel = self.viewModel
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieInfoCell", for: indexPath) as! MovieInfoCell
            cell.movieDetailViewModel = self.viewModel
            
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewCell", for: indexPath) as! UserReviewCell
            cell.userReview = self.viewModel.userReviews[indexPath.row]
            if indexPath.row == self.viewModel.userReviews.count - 4 && indexPath.row > 4 {
                self.currentPage += 1
                self.viewModel.getUserReviews(page: self.currentPage)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
