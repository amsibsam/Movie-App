//
//  GenresViewModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class GenresViewModel {
    private let navigator: GenresNavigator
    private let interactor: GenresInteractor
    private let refreshSubject: PublishSubject<Void> = PublishSubject<Void>()
    private let errorSubject: PublishSubject<String> = PublishSubject<String>()
    
    var genres: [Genre] = []
    
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
    
    init(navigator: GenresNavigator, interactor: GenresInteractor) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    func getGenres() {
        self.interactor.getGenres(onSuccess: { [weak self] (genres) in
            self?.genres = genres
            self?.refreshSubject.on(.next(()))
        }) { [weak self] (error) in
            self?.errorSubject.on(.next(error))
        }
    }
    
    func openMovies(withGenre genre: Genre) {
        self.navigator.openMovies(withGenre: genre)
    }
    
    func openMovie(_ movie: Movie) {
        self.navigator.openMovie(movie)
    }
}
