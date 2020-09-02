//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

protocol MovieDetailInteractor {
    
    var networkService: NetworkService { get }
    
    init(networkService: NetworkService)
    
    func getMovie(withId id: Int, onSuccess: @escaping (Movie) -> Void, onError: @escaping (String) -> Void)
    
    func getVideo(withMovieId id: Int, onSuccess: @escaping (Video) -> Void, onError: @escaping (String) -> Void)
    
    func getUserReview(onMovieId id: Int, page: Int, onSuccess: @escaping (_ userReviews: [UserReview], _ totalPages: Int) -> Void, onError: @escaping (String) -> Void)
}
