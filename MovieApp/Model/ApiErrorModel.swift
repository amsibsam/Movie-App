//
//  ApiErrorModel.swift
//  MovieApp
//
//  Created by MTMAC36 on 01/09/20.
//  Copyright © 2020 rahardyan. All rights reserved.
//

import Foundation

enum ApiErrorModel: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case emptyData
    case serializationError
    
    var errorMessage: String {
        switch self {
        case .apiError:
            return "Server Error"
        case .invalidEndpoint:
            return "Invalid Endpoint"
        case .invalidResponse:
            return "Invalid Response"
        case .emptyData:
            return "There is no data"
        case .serializationError:
            return "Error when try to serialize the response"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey : errorMessage]
    }
}
