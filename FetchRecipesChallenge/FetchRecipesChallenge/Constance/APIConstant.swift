//
//  APIConstant.swift
//  FetchRecipesChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation

/**
 An enum containing constants for API endpoints related to Recipes.
 This enum provides base URLs for recipes.
 */
enum APIConstant {
    private enum Recipes {
        static let allRecipesBase = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    }

    static func getAllRecipeEndpoint() -> String {
        return Recipes.allRecipesBase
    }
}
