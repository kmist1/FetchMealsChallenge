//
//  APIConstant.swift
//  FetchMealsChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation

/**
 An enum containing constants for API endpoints related to Recipes.
 This enum provides base URLs for filtering meals and fetching mock/tests data.
 */
enum APIConstant {
    private enum Recipes {
        static let allRecipesBase = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        static let allRecipesMockBaseAPI = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        static let emptyDataAPI = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    }

    static func getAllRecipeEndpoint() -> String {
        return Recipes.allRecipesBase
    }

    static func getAllRecipeMockEndpoint() -> String {
        return Recipes.allRecipesMockBaseAPI
    }

    static func getEmptyDataEndpoint() -> String {
        return Recipes.emptyDataAPI
    }
}
