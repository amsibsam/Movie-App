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
    private let genre: Genre
    private let navigator: MoviesNavigator
    private let interactor: MoviesInteractor
    private let refreshSubject: PublishSubject<Void> = PublishSubject<Void>()
    private let titleSubject: PublishSubject<String> = PublishSubject<String>()
    private let errorSubject: PublishSubject<String> = PublishSubject<String>()
    
    var movies: [Movie] = []
    
    var titleDriver: Driver<String> {
        get {
            titleSubject.asDriver(onErrorJustReturn: "")
        }
    }
    
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
    
    init(genre: Genre, navigator: MoviesNavigator, interactor: MoviesInteractor) {
        self.genre = genre
        self.navigator = navigator
        self.interactor = interactor
    }
    
    func getTitle() {
        titleSubject.on(.next("\(genre.name) Movies"))
    }
    
    func getMovies(page: Int) {
        interactor.getMovies(withGenreId: genre.id, page: page, onSuccess: { [weak self] (movies) in
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
