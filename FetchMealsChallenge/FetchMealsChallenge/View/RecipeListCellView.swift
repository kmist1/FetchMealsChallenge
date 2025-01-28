//
//  RecipeListCellView.swift
//  FetchMealsChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import SwiftUI

struct RecipeListCellView: View {
    let recipe: Recipe
    private let imageService = RecipesImageService.shared
    @State private var recipeImage: UIImage?

    init(recipe: Recipe, recipeImage: UIImage? = nil) {
        self.recipe = recipe
        self.recipeImage = recipeImage
    }

    var body: some View {
        HStack(alignment: .top) {
            if let recipeImage {
                Image(uiImage: recipeImage)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.trailing)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.trailing)
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .fontWeight(.light)
            }

            Spacer()
        }
        .onAppear {
            // load recipe image
            imageService.loadRecipeImage(with: recipe.photoURLSmall?.absoluteString ?? "") { image in
                if let image {
                    self.recipeImage = image
                }
            }
        }
    }
}

#Preview {
    RecipeListCellView(recipe: Recipe(id: "123", cuisine: "American", name: "Cheesstack", photoURLLarge: nil, photoURLSmall: nil, sourceURL: nil, youtubeURL: nil))
}
