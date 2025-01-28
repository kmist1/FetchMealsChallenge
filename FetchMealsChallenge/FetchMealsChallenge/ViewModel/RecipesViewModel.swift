//
//  RecipesViewModel.swift
//  FetchMealsChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation
import Combine

enum RecipesPageState: Equatable {
    
    case inProgress
    case success([Recipe])
    case failure(String)
}

class RecipesPageViewModel: ObservableObject {

    private let networkManager: RecipesNetworkServiceProtocol?
    @Published var recipePageStateManager: RecipesPageState = .inProgress
    private var recipes: [Recipe] = []

    init(networkManager: RecipesNetworkServiceProtocol = NetworkManager.shared) {
        self.networkManager = networkManager

        Task {
            let endpoint = APIConstant.getAllRecipeEndpoint()
            await self.loadRecipes(with: endpoint)
        }
    }

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

                // Generilize error for malformed data
                switch error {
                case .decodingError(let error):
                    debugPrint("Decoding Error: ", error.localizedDescription)
                    self.recipePageStateManager = .failure("Something is wrong.")
                default:
                    print("Error getting data: ",error)
                    self.recipePageStateManager = .failure(error.localizedDescription)
                }
            }
        }
    }
}
