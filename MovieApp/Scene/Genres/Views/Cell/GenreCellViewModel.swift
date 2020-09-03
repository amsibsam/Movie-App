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

final class GenreCellViewModel {
    
    private let cellIndex: Int
    private let genresViewModel: GenresViewModel
    private let interactor: GenresInteractor
    private let refreshSubject: PublishSubject<Void> = PublishSubject<Void>()
    private let errorSubject: PublishSubject<String> = PublishSubject<String>()
    private let genreSubject: PublishSubject<Genre?> = PublishSubject<Genre?>()
    
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
    
    var genreDriver: Driver<Genre?> {
        get {
            genreSubject.asDriver(onErrorJustReturn: nil)
        }
    }
    
    init(cellIndex: Int, genresViewModel: GenresViewModel, interactor: GenresInteractor) {
        self.genresViewModel = genresViewModel
        self.interactor = interactor
        self.cellIndex = cellIndex
    }
    
    func getMovies() {
        if cellIndex >= genresViewModel.genres.count {
            errorSubject.on(.next("movies index not found"))
            return
        }
        
        interactor.getMovies(withGenreId: genresViewModel.genres[cellIndex].id, onSuccess: { [weak self] (movies) in
            self?.movies = movies
            self?.refreshSubject.on(.next(()))
        }) { [weak self] (error) in
            self?.errorSubject.on(.next(error))
        }
    }
    
    func getGenre() {
        if cellIndex >= genresViewModel.genres.count {
            errorSubject.on(.next("genre index not found"))
            return
        }
        
        genreSubject.on(.next(genresViewModel.genres[cellIndex]))
    }
    
    func openMovies() {
        if cellIndex >= genresViewModel.genres.count {
            errorSubject.on(.next("genre index not found"))
            return
        }
        
        genresViewModel.openMovies(withGenre: genresViewModel.genres[cellIndex] )
    }
    
    func openMovie(atIndex index: Int) {
        if index >= movies.count {
            errorSubject.on(.next("genre index not found"))
            return
        }
        
        genresViewModel.openMovie(movies[index])
    }
}
