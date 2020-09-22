//
//  GenreCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell, GenreCellViewProtocol {
    
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    @IBOutlet weak var buttonSeeMore: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelErrorMessage: UILabel!
    
    var presenter: GenreCellPresenterProtocol? {
        didSet {
            presenter?.getGenre()
            presenter?.getMovies()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        buttonSeeMore.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionViewMovies.reloadData()
    }
    
    private func setupCollectionView() {
        collectionViewMovies.delegate = self
        collectionViewMovies.dataSource = self
        collectionViewMovies.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewMovies.collectionViewLayout = collectionViewLayout
        
        collectionViewMovies.register(UINib(nibName: "MovieTileCell", bundle: Bundle(for: GenreCell.self)), forCellWithReuseIdentifier: "MovieTileCell")
    }
    
    @IBAction func tapSeeMore(_ sender: Any) {
        presenter?.openMovies()
    }
    
    // MARK: Presenter delegate
    func reloadTableView() {
        collectionViewMovies.reloadData()
        labelErrorMessage.isHidden = true
    }
    
    func showLoading() {
        self.activityIndicator.startLoading(true)
    }
    
    func stopLoading() {
        activityIndicator.startLoading(false)
    }
    
    func showError(errorMessage: String) {
        labelErrorMessage.isHidden = false
        labelErrorMessage.text = errorMessage
    }
    
    func showGenre(genre: Genre) {
        labelGenre.text = genre.name
    }
    
}

extension GenreCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 212)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTileCell", for: indexPath) as! MovieTileCell
        cell.presenter = MovieTileCellPresenter(movie: self.presenter?.movies[indexPath.row], interface: cell)
        return cell
    }
}

extension GenreCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.presenter?.openMovie(atIndex: indexPath.row)
    }
}
