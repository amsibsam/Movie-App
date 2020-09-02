//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieDetailViewModel {
    private let movie: Movie
    private let navigator: MovieDetailNavigator
    private let interactor: MovieDetailInteractor
    private var reviewsTotalPages: Int = 1
    private let movieSubject: BehaviorSubject<Movie?> = BehaviorSubject<Movie?>(value: nil)
    private let videoSubject: PublishSubject<Video?> = PublishSubject<Video?>()
    private let errorSubject: PublishSubject<String> = PublishSubject<String>()
    private let reviewRefreshSubject: PublishSubject<Void> = PublishSubject<Void>()
    
    var userReviews: [UserReview] = []
    var movieDriver: Driver<Movie?> {
        get {
            movieSubject.asDriver(onErrorJustReturn: nil)
        }
    }
    
    var videoDriver: Driver<Video?> {
        get {
            videoSubject.asDriver(onErrorJustReturn: nil)
        }
    }
    
    var errorDriver: Driver<String> {
        get {
            errorSubject.asDriver(onErrorJustReturn: "")
        }
    }
    
    var reviewRefreshDriver: Driver<Void> {
        get {
            reviewRefreshSubject.asDriver(onErrorJustReturn: ())
        }
    }
    
    init(movie: Movie, navigator: MovieDetailNavigator, interactor: MovieDetailInteractor) {
        self.movie = movie
        self.navigator = navigator
        self.interactor = interactor
    }
    
    func getMovie() {
        movieSubject.on(.next(movie))
        interactor.getMovie(withId: movie.id, onSuccess: { [weak self] (movie) in
            self?.movieSubject.on(.next(movie))
        }) { [weak self] (error) in
            self?.errorSubject.on(.next(error))
        }
    }
    
    func getVideo() {
        interactor.getVideo(withMovieId: movie.id, onSuccess: { [weak self] (video) in
            self?.videoSubject.on(.next(video))
        }) { [weak self] (error) in
            self?.errorSubject.on(.next(error))
        }
    }
    
    func getUserReviews(page: Int) {
        if page > reviewsTotalPages {
            return
        }
        
        interactor.getUserReview(onMovieId: movie.id, page: page, onSuccess: { [weak self] (userReviews, totalPages) in
            self?.reviewsTotalPages = totalPages
            
            if page == 1 {
                self?.userReviews = userReviews
            } else {
                self?.userReviews.append(contentsOf: userReviews)
            }
            self?.reviewRefreshSubject.on(.next(()))
            
        }) { [weak self] (error) in
            self?.errorSubject.on(.next(error))
        }
    }
    
}
