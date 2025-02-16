//
//  NetworkManager.swift
//  FetchRecipesChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation

/// A protocol defining a network service responsible for fetching recipe data.
protocol RecipesNetworkServiceProtocol {

    /// Fetches an array of recipes from the given URL.
    ///
    /// - Parameter url: The URL endpoint from which to fetch recipe data.
    /// - Returns: An array of `Recipe` objects representing the fetched recipes.
    /// - Throws: A `NetworkError` if the fetch operation fails.
    func fetchRecipes(with url: String) async throws -> [Recipe]
}

/**
 A singleton class responsible for handling network requests and data fetching operations.
 This class utilizes Combine's `async/await` syntax for asynchronous network calls and error handling.
 */
final class NetworkManager {

    //MARK: Properties
    // Singleton Instance
    static let shared = NetworkManager()

    private(set) var session = URLSession.shared

    // Private initializer to prevent direct creation
    private init() {}


    //MARK: Private Methods
    /// Generic private method to fetch data for Recipes or recipe
    /// - Parameters:
    ///     - url: The URL of the API endpoint to fetch data from.
    /// - Throws: An error representing a network or decoding issue.
    /// - Returns: The decoded data object of the specified type `DataType`.
    private func fetchData<T: Decodable>(from url: String) async throws -> T {

        guard let url = URL(string: url) else { throw NetworkError.invalidURL }

        let request = URLRequest(url: url)
        let response: (Data, URLResponse)

        do {
            response = try await session.data(for: request)
        } catch {
            throw NetworkError.dataRequestFailed(error)
        }

        let httpResponse = response.1 as! HTTPURLResponse
        guard (200...300) ~= httpResponse.statusCode else {
            throw NetworkError.statusCode(httpResponse.statusCode)
        }

        let jsonDecoder = JSONDecoder()

        do {
            let data = try jsonDecoder.decode(T.self, from: response.0)
            return data
        } catch {
            throw NetworkError.decodingError(error)
        }
    }


    /// This method is intended for testing purposes, allowing you to inject a custom `URLSession`
    /// to facilitate testing of network requests with mocked responses.
    /// - Parameter session: The custom `URLSession` instance to be used for network requests.
    func updateSessionForTest(session: URLSession) {
        self.session = session
    }
}

extension NetworkManager: RecipesNetworkServiceProtocol {
    public func fetchRecipes(with url: String) async throws -> [Recipe] {
        let data: RecipeResponse = try await self.fetchData(from: url)

        // Check for malformed data (if validation fails, throw an error)
        guard data.recipes.allSatisfy({ $0.name != "" && $0.cuisine != "" }) else {
            throw URLError(.badServerResponse)
        }

        // Check for empty list
        if data.recipes.isEmpty {
            throw NetworkError.noRecipeAvailable
        }

        var recipes = data.recipes

        // Sorting recipes by cuisines alphabetical order (i.e American, Bulgerien, Chinese..)
        recipes.sort { $0.cuisine < $1.cuisine }

        return recipes

    }
}
