//
//  GenresInteractorImpl.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

final class GenresInteractorImpl: GenresInteractor {
    let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    func getGenres(onSuccess: @escaping ([Genre]) -> Void, onError: @escaping (String) -> Void) {
        guard let genresURL = URL(string: AppServerConstant.genres) else {
            return
        }
        
        self.networkService.request(url: genresURL, method: .get, query: nil, requestBody: nil) { (result: Result<GenreResponse, ApiErrorModel>) in
            switch result {
            case .failure(let error):
                onError(error.errorMessage)
            case .success(let genreResponse):
                onSuccess(genreResponse.genres)
            }
        }
    }
    
    func getMovies(withGenreId id: Int, onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        guard let movieDiscoverURL = URL(string: AppServerConstant.movies) else {
            return
        }
        
        self.networkService.request(url: movieDiscoverURL,
                                    method: .get,
                                    query: [
                                        "with_genres" : "\(id)",
                                        "page" : "1"],
                                    requestBody: nil)
        { (result: Result<DiscoveryResponse, ApiErrorModel>) in
            switch result {
            case .failure(let error):
                onError(error.errorMessage)
            case .success(let discoveryResponse):
                onSuccess(discoveryResponse.results ?? [])
            }
        }
    }
}
