//
//  RecipesViewModel.swift
//  FetchRecipesChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation
import Combine

enum SortingOption: String, CaseIterable {
    case category = "Cuisine"
    case name = "Name"
}

/// Represents the different states of the recipes page.
enum RecipesPageState: Equatable {

    /// Indicates that the data is currently being loaded.
    case inProgress

    /// Indicates that the data was successfully fetched.
    /// - Parameter recipes: The list of successfully retrieved recipes.
    case success([Recipe])

    /// Indicates that an error occurred while fetching data.
    /// - Parameter message: The error message describing the issue.
    case failure(String)
}

/// ViewModel responsible for fetching and managing recipe data.
class RecipesPageViewModel: ObservableObject {

    /// The network service responsible for fetching recipe data.
    private let networkManager: RecipesNetworkServiceProtocol?

    /// Published state that the view observes to update UI accordingly.
    @Published var recipePageStateManager: RecipesPageState = .inProgress

    /// Local cache of fetched recipes.
    private var recipes: [Recipe] = []

    /// The selected sorting option (default is by category/cuisine)
    @Published var sortingOption: SortingOption = .category {
        didSet {
            sortRecipes()
        }
    }

    /// Initializes the ViewModel and starts fetching recipes on creation.
    /// - Parameter networkManager: The network service used to fetch data.
    init(networkManager: RecipesNetworkServiceProtocol = NetworkManager.shared) {
        self.networkManager = networkManager

        Task {
            let endpoint = APIConstant.getAllRecipeEndpoint()
            await self.loadRecipes(with: endpoint)
        }
    }

    /// Fetches the recipes from the given API endpoint.
    /// Updates `recipePageStateManager` based on the success or failure of the request.
    ///
    /// - Parameter endpoint: The API endpoint to fetch recipe data from.
    @MainActor
    func loadRecipes(with endpoint: String) async {
        do {
            guard let recipes = try await networkManager?.fetchRecipes(with: endpoint) else {
                self.recipePageStateManager = .failure("Something went wrong.")
                return
            }

            self.recipes = recipes
            self.recipePageStateManager = .success(self.recipes)

        } catch {
            if let error = error as? NetworkError {
                // Generalize error for malformed data
                switch error {
                case .decodingError(let error):
                    debugPrint("Decoding Error: ", error.localizedDescription)
                    self.recipePageStateManager = .failure("Something is wrong.")
                default:
                    print("Error getting data: ", error)
                    self.recipePageStateManager = .failure(error.localizedDescription)
                }
            }
        }
    }

    /// Sorts recipes based on the selected sorting option.
    private func sortRecipes() {
        switch sortingOption {
        case .category:
            self.recipePageStateManager = .success(recipes.sorted { $0.cuisine < $1.cuisine })
        case .name:
            self.recipePageStateManager = .success(recipes.sorted { $0.name < $1.name })
        }
    }
}
