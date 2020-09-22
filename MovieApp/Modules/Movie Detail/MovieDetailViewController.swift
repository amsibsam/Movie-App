//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    
    var presenter: MovieDetailPresenterProtocol?
    private var currentPage: Int = 1

    @IBOutlet weak var tableViewContent: UITableView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var viewGradient: UIView!
    
    init() {
        super.init(nibName: "MovieDetailViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getMoviePoster()
        presenter?.getUserReview(page: currentPage)
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        viewGradient.setGradient(startColor: #colorLiteral(red: 0.1323497891, green: 0.1323794127, blue: 0.132345885, alpha: 1), endColor: #colorLiteral(red: 0.16707775, green: 0.1671129167, blue: 0.1670731306, alpha: 0.2552266725), direction: .vertical)
        imageViewPoster.contentMode = .scaleAspectFill
        setupTableView()
    }
    
    private func setupTableView() {
        tableViewContent.delegate = self
        tableViewContent.dataSource = self
        tableViewContent.allowsSelection = false
        tableViewContent.estimatedRowHeight = UITableView.automaticDimension
        tableViewContent.register(UINib(nibName: "VideoHeaderCell", bundle: Bundle(for: MovieDetailViewController.self)), forCellReuseIdentifier: "VideoHeaderCell")
        tableViewContent.register(UINib(nibName: "MovieInfoCell", bundle: Bundle(for: MovieDetailViewController.self)), forCellReuseIdentifier: "MovieInfoCell")
        tableViewContent.register(UINib(nibName: "UserReviewCell", bundle: Bundle(for: MovieDetailViewController.self)), forCellReuseIdentifier: "UserReviewCell")
    }
    
    // MARK: Presenter delegate
    func showMoviePoster(moviePosterUrl: URL) {
        tableViewContent.reloadData()
        imageViewPoster.sd_setImage(with: moviePosterUrl)
    }
    
    func refreshTableView() {
        tableViewContent.reloadData()
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
        
        return self.presenter?.userReviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            view.backgroundColor = #colorLiteral(red: 0.1798019707, green: 0.1798391342, blue: 0.1797970533, alpha: 1)
            let labelTitle = UILabel()
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            labelTitle.font = .boldSystemFont(ofSize: 20)
            labelTitle.textColor = .white
            labelTitle.text = "Reviews"
            
            view.addSubview(labelTitle)
            
            labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
            labelTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = VideoHeaderCellRouter.createModule(with: self.presenter?.movie, tableView: tableView)
            
            return cell
        } else if indexPath.section == 1 {
            let cell = MovieInfoCellRouter.createModule(with: self.presenter?.movie, tableView: tableView)
            
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewCell", for: indexPath) as! UserReviewCell
            cell.userReview = self.presenter?.userReviews[indexPath.row]
            if indexPath.row == (self.presenter?.userReviews.count ?? 0) - 4 && indexPath.row > 4 {
                self.currentPage += 1
                self.presenter?.getUserReview(page: self.currentPage)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

extension MovieDetailViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if #available(iOS 13.0, *) {
            return
        }
        
        if scrollView.contentOffset.y < -110 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
