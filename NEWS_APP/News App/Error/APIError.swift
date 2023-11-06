//
//  APIError.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import Foundation


enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
    
}


extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
                return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
