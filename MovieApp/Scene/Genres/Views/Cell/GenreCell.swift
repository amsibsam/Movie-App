//
//  GenreCell.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GenreCell: UITableViewCell {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    @IBOutlet weak var buttonSeeMore: UIButton!
    
    var viewModel: GenreCellViewModel? {
        didSet {
            bindView()
            viewModel?.getGenre()
            viewModel?.getMovies()
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
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewMovies.collectionViewLayout = collectionViewLayout
        
        collectionViewMovies.register(UINib(nibName: "MovieTileCell", bundle: Bundle(for: GenreCell.self)), forCellWithReuseIdentifier: "MovieTileCell")
    }
    
    private func bindView() {
        viewModel?.refreshDriver.drive(onNext: { [weak self] (_) in
            self?.collectionViewMovies.reloadData()
        })
        .disposed(by: disposeBag)
        
        viewModel?.errorDriver.drive(onNext: { (error) in
            // TODO: handle error later
            print("error get movies based on genre \(error)")
        })
        .disposed(by: disposeBag)
        
        viewModel?.genreDriver.drive(onNext: { [weak self] (genre) in
            guard let genre = genre else {
                return
            }
            
            self?.labelGenre.text = genre.name
        })
        .disposed(by: disposeBag)
    }
    
    @IBAction func tapSeeMore(_ sender: Any) {
        viewModel?.openMovies()
    }
    
}

extension GenreCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 212)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieTileCell", for: indexPath) as! MovieTileCell
        cell.viewModel = MovieTileCellViewModel(movie: self.viewModel?.movies[indexPath.row])
        return cell
    }
    
    
}

extension GenreCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.viewModel?.openMovie(atIndex: indexPath.row)
    }
}
