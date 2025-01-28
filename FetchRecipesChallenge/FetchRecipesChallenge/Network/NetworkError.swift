//
//  NetworkError.swift
//  FetchRecipesChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation

//  It represents various network-related errors that can occur during the
//  execution of network requests. Each case provides a user-friendly description
//  through the localizedDescription.
enum NetworkError: Error, Equatable {
    case invalidURL
    case dataRequestFailed(Error)
    case statusCode(Int)
    case decodingError(Error)
    case noRecipeAvailable
    case unknownError

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case let .dataRequestFailed(error):
            return "Data request failed with error: \(error.localizedDescription)"
        case let .statusCode(code):
            return "Network request failed with status code: \(code)"
        case let .decodingError(error):
            return "Error decoding response: \(error.localizedDescription)"
        case .noRecipeAvailable:
            return "No recipes available."
        case .unknownError:
            return "An unknown network error occurred."
        }
    }

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case let (.dataRequestFailed(lhsError), .dataRequestFailed(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.statusCode(lhsCode), .statusCode(rhsCode)):
            return lhsCode == rhsCode
        case let (.decodingError(lhsError), .decodingError(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.unknownError, .unknownError):
            return true
        default:
            return false
        }
    }
}

