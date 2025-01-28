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
                Text("Recipes")
                    .font(.title)
                Divider().background(ignoresSafeAreaEdges: [.leading, .trailing])
                switch recipesViewModel.recipePageStateManager {
                case .inProgress:
                    ProgressView()
                case .success(let recipes):
                    ScrollView {
                        LazyVStack {
                            ForEach(recipes, id: \.self) { recipe in
                                RecipeListCellView(recipe: recipe)
                                    .frame(height: 100)
                                Divider()
                            }
                        }
                    }
                case .failure(let error):
                    Spacer()
                    Text(error.description)
                    Spacer()
                }
            }
            .padding()
            .refreshable {
                // Reload recipes when user pulls down
                Task {
                    let endpoint = APIConstant.getAllRecipeEndpoint()
                    await recipesViewModel.loadRecipes(with: endpoint)
                }
            }
        }
    }
}

#Preview {
    RecipesPageView()
}
