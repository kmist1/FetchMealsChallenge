//
//  xyc.swift
//  FetchMealsChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import XCTest
import Combine
@testable import FetchMealsChallenge

class MockRecipesNetworkService: RecipesNetworkServiceProtocol {

    var mockResponse: Result<[Recipe], NetworkError>?

    func fetchRecipes(with endpoint: String) async throws -> [Recipe] {
        if let response = mockResponse {
            switch response {
            case .success(let recipes):
                return recipes
            case .failure(let error):
                throw error
            }
        }
        throw NetworkError.unknownError
    }
}
