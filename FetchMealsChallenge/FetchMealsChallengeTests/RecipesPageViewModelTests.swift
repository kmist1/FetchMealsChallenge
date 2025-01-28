//
//  FetchMealsChallengeTests.swift
//  FetchMealsChallengeTests
//
//  Created by Krunal Mistry on 1/27/25.
//

import XCTest
@testable import FetchMealsChallenge

class RecipesPageViewModelTests: XCTestCase {

    var viewModel: RecipesPageViewModel!
    var mockNetworkService: MockRecipesNetworkService!
    var networkService: RecipesNetworkServiceProtocol!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockRecipesNetworkService()
        networkService = NetworkManager.shared
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        networkService = nil
        super.tearDown()
    }

    /// Test: Fetching recipes successfully
    func testLoadRecipes_Success() async {
        // Mock successful response
        let mockRecipes = [
            Recipe(id: "123", cuisine: "Italian", name: "Pasta", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil)
        ]
        viewModel = RecipesPageViewModel(networkManager: mockNetworkService)
        mockNetworkService.mockResponse = .success(mockRecipes)

        // Call the method
        await viewModel.loadRecipes(with: APIConstant.getAllRecipeEndpoint())

        // Verify state
        XCTAssertEqual(viewModel.recipePageStateManager, .success(mockRecipes))
    }

    /// Test: Handling empty response
    func testLoadRecipes_EmptyData() async {
        // Mock empty response
        mockNetworkService.mockResponse = .success([])

        viewModel = RecipesPageViewModel(networkManager: networkService)

        // Call the method
        await viewModel.loadRecipes(with: MockAPIConstant.getEmptyDataEndpoint())

        // Verify state
        XCTAssertEqual(viewModel.recipePageStateManager, .failure("No recipes available."))
    }

    /// Test: Handling malformed data (Decoding error)
    func testLoadRecipes_MalformedData() async {
        // Mock decoding error response
        mockNetworkService.mockResponse = .failure(NetworkError.decodingError(NSError(domain: "", code: -1, userInfo: nil)))

        viewModel = RecipesPageViewModel(networkManager: networkService)

        // Call the method
        await viewModel.loadRecipes(with: MockAPIConstant.getAllRecipeMockEndpoint())

        // Verify state
        XCTAssertEqual(viewModel.recipePageStateManager, .failure("Something is wrong."))
    }
}
