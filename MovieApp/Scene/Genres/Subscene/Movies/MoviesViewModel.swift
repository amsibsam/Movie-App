//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MoviesViewModel {
    private let genreId: Int
    private let navigator: MoviesNavigator
    private let interactor: MoviesInteractor
    private let refreshSubject: PublishSubject<Void> = PublishSubject<Void>()
    private let errorSubject: PublishSubject<String> = PublishSubject<String>()
    
    var movies: [Movie] = []
    
    var refreshDriver: Driver<Void> {
        get {
            refreshSubject.asDriver(onErrorJustReturn: ())
        }
    }
    
    var errorDriver: Driver<String> {
        get {
            errorSubject.asDriver(onErrorJustReturn: "")
        }
    }
    
    init(genreId: Int, navigator: MoviesNavigator, interactor: MoviesInteractor) {
        self.genreId = genreId
        self.navigator = navigator
        self.interactor = interactor
    }
    
    func getMovies(page: Int) {
        interactor.getMovies(withGenreId: genreId, page: page, onSuccess: { [weak self] (movies) in
            if page == 1 {
                self?.movies = movies
            } else {
                self?.movies.append(contentsOf: movies)
            }
            
            self?.refreshSubject.on(.next(()))
        }) { [weak self] (error) in
            self?.errorSubject.on(.next(error))
        }
    }
    
    func openMovieDetail(atIndex index: Int) {
        if index >= movies.count {
            return
        }
        
        navigator.openMovieDetail(with: movies[index])
    }
}
