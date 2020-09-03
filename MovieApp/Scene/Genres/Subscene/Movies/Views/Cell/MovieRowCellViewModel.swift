//
//  MovieRowCellViewModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 02/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieRowCellViewModel {
    private let movie: Movie?
    private let movieSubject: PublishSubject<Movie?> = PublishSubject<Movie?>()
    
    var movieDriver: Driver<Movie?> {
        get {
            movieSubject.asDriver(onErrorJustReturn: nil)
        }
    }
    
    init(movie: Movie?) {
        self.movie = movie
    }
    
    func getMovie() {
        movieSubject.on(.next(movie))
    }
}
