//
//  RecipesPageView.swift
//  FetchRecipesChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import SwiftUI

struct RecipesPageView: View {
    @ObservedObject var recipesViewModel: RecipesPageViewModel = RecipesPageViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Title & Sorting Picker
                HStack {
                    Text("Recipes")
                        .font(.title)
                    Spacer()
                    Picker("Sort by", selection: $recipesViewModel.sortingOption) {
                        ForEach(SortingOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // Dropdown-style menu
                }
                .padding()

                Divider().background(ignoresSafeAreaEdges: [.leading, .trailing])

                switch recipesViewModel.recipePageStateManager {
                case .inProgress:
                    ProgressView()
                        .padding()

                case .success(let recipes):
                    if recipes.isEmpty {
                        Text("No recipes available.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(recipes, id: \.id) { recipe in
                                    RecipeListCellView(recipe: recipe)
                                        .frame(height: 100)
                                    Divider()
                                }
                            }
                        }
                        .refreshable {
                            Task {
                                let endpoint = APIConstant.getAllRecipeEndpoint()
                                await recipesViewModel.loadRecipes(with: endpoint)
                                recipesViewModel.sortingOption = .category
                            }
                        }
                    }

                case .failure(let error):
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
    }
}
#Preview {
    RecipesPageView()
}
