//
//  GenreInteractorImplTest.swift
//  MovieAppTests
//
//  Created by MTMAC36 on 03/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import XCTest

class GenresInteractorImplTest: XCTestCase {
    var genresInteractorImpl: GenresInteractorImpl!
    private let networkServiceMock: NetworkServiceMock = NetworkServiceMock(urlSessionService: URLSessionServiceMock())
    
    func testInit() throws {
        genresInteractorImpl = GenresInteractorImpl(networkService: networkServiceMock)
        
        XCTAssertNotNil(genresInteractorImpl)
        XCTAssertNotNil(genresInteractorImpl.networkService)
    }
    
    func testGetGenresError() {
        genresInteractorImpl = GenresInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.errorResponse = .invalidResponse
        
        let expectation = XCTestExpectation(description: "testGetGenresError")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        genresInteractorImpl.getGenres(onSuccess: { (genres) in
            isSuccess = true
            expectation.fulfill()
        }) { (error) in
            isError = true
            errorResult = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(isError)
        
    }
    
    func testGetGenresSuccess() {
        genresInteractorImpl = GenresInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = GenreResponse(genres: [Genre(id: 0, name: "dummy")])
        
        let expectation = XCTestExpectation(description: "testGetGenresSuccess")
        var successResult: [Genre]?
        var isSuccess = false
        var isError = false
        genresInteractorImpl.getGenres(onSuccess: { (genres) in
            isSuccess = true
            successResult = genres
            expectation.fulfill()
        }) { (error) in
            isError = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(successResult)
        XCTAssertTrue(isSuccess)
        XCTAssertFalse(isError)
        
    }
    
    func testGetMoviesError() {
        genresInteractorImpl = GenresInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.errorResponse = .invalidResponse
        
        let expectation = XCTestExpectation(description: "testGetMoviesError")
        var errorResult: String?
        var isSuccess = false
        var isError = false
        genresInteractorImpl.getMovies(withGenreId: 1, onSuccess: { (genres) in
            isSuccess = true
            expectation.fulfill()
        }) { (error) in
            isError = true
            errorResult = error
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertFalse(isSuccess)
        XCTAssertTrue(isError)
        
    }
    
    func testGetMoviesSuccess() {
        genresInteractorImpl = GenresInteractorImpl(networkService: networkServiceMock)
        networkServiceMock.successResponse = DiscoveryResponse(page: 1, totalResults: 1, totalPages: 1, results: [Movie.generateDummyMovie()])
        
        let expectation = XCTestExpectation(description: "testGetMoviesSuccess")
        var successResult: [Movie]?
        var isSuccess = false
        var isError = false
        genresInteractorImpl.getMovies(withGenreId: 1, onSuccess: { (movies) in
            isSuccess = true
            successResult = movies
            expectation.fulfill()
        }) { (error) in
            isError = true
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(successResult)
        XCTAssertTrue(isSuccess)
        XCTAssertFalse(isError)
        
    }
}

class URLSessionServiceMock: URLSessionService {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
    }
}

class NetworkServiceMock: NetworkService {
    var errorResponse: ApiErrorModel?
    var successResponse: Codable?
    
    required init(urlSessionService: URLSessionService = URLSessionServiceMock()) {
        
    }
    
    func request<D: Codable>(url: URL, method: HTTPMethod, query: [String: String]?, requestBody: [String: Any]?, completion: @escaping (Result<D, ApiErrorModel>) -> ()) {
        if let successResponse = self.successResponse {
            completion(.success(successResponse as! D))
            return
        }
        
        if let errorResponse = self.errorResponse {
            completion(.failure(errorResponse))
        }
    }
}
