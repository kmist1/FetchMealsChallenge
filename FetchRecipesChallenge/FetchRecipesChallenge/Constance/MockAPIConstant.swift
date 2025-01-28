//
//  MockAPIConstant.swift
//  FetchRecipesChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation

/**
 This enum provides base URLs for fetching mock/tests data.
 */
enum MockAPIConstant {
    private enum Recipes {
        static let allRecipesMockBaseAPI = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        static let emptyDataAPI = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    }

    static func getAllRecipeMockEndpoint() -> String {
        return Recipes.allRecipesMockBaseAPI
    }

    static func getEmptyDataEndpoint() -> String {
        return Recipes.emptyDataAPI
    }
}
