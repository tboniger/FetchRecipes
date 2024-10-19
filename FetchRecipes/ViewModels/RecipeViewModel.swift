//
//  RecipeViewModel.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation
import SwiftUI

@MainActor
class RecipeViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let networkClient: NetworkClient
    let imageLoader: ImageLoader

    init(networkClient: NetworkClient = NetworkClient(),
         imageLoader: ImageLoader = ImageLoader()) {
        self.networkClient = networkClient
        self.imageLoader = imageLoader
    }

    func recipes() async {
        
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let request = RecipeListRequest()
                let response: RecipeResponse = try await networkClient.performRequest(request: request)
                self.recipes = response.recipes
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
        
    }

}
