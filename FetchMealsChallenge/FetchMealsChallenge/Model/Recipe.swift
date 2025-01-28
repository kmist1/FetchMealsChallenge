//
//  Recipe.swift
//  FetchMealsChallenge
//
//  Created by Krunal Mistry on 1/27/25.
//

import Foundation

// Model for the root object
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

// Model for a single recipe
struct Recipe: Codable, Sendable, Identifiable, Hashable  {
    var id: String

    let cuisine: String
    let name: String
    let photoURLLarge: URL?
    let photoURLSmall: URL?
    let sourceURL: URL?
    let youtubeURL: URL?

    // CodingKeys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
