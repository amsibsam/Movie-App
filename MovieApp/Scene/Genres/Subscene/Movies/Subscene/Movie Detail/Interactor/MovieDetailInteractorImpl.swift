//
//  MovieDetailInteractorImpl.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

final class MovieDetailInteractorImpl: MovieDetailInteractor {
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getMovie(withId id: Int, onSuccess: @escaping (Movie) -> Void, onError: @escaping (String) -> Void) {
        guard let movieUrl = URL(string: AppServerConstant.movie(movieId: id)) else {
            return
        }
        
        networkService.request(url: movieUrl, method: .get, query: nil, requestBody: nil) { (result: Result<Movie, ApiErrorModel>) in
            switch result {
            case .failure(let error):
                onError(error.errorMessage)
            case .success(let movie):
                onSuccess(movie)
            }
        }
    }
    
    func getVideo(withMovieId id: Int, onSuccess: @escaping (Video) -> Void, onError: @escaping (String) -> Void) {
        guard let movieVideoUrl = URL(string: AppServerConstant.movieVideo(movieId: id)) else {
            return
        }
        
        networkService.request(url: movieVideoUrl, method: .get, query: nil, requestBody: nil) { (result: Result<VideoResponse, ApiErrorModel>) in
            switch result {
            case .failure(let error):
                onError(error.errorMessage)
            case .success(let videoResponse):
                guard let trailerYoutube = videoResponse.results?.filter({ $0.type == "Trailer" && $0.site == "YouTube" }).first else {
                    onError("no Trailer on YouTube site")
                    return
                }
                
                onSuccess(trailerYoutube)
            }
        }
    }
    
    func getUserReview(onMovieId id: Int, page: Int, onSuccess: @escaping ([UserReview], Int) -> Void, onError: @escaping (String) -> Void) {
        guard let userReviewUrl = URL(string: AppServerConstant.userReviews(movieId: id)) else {
            return
        }
        
        networkService.request(url: userReviewUrl, method: .get, query: ["page": "\(page)"], requestBody: nil) { (result: Result<UserReviewResponse, ApiErrorModel>) in
            switch result {
            case .failure(let error):
                onError(error.errorMessage)
            case .success(let userReviewResponse):
                onSuccess(userReviewResponse.results, userReviewResponse.totalPages ?? 0)
            }
        }
    }
}
