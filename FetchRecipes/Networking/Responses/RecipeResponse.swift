//
//  RecipeResponse.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//
import Foundation

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
