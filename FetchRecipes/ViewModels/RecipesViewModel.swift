//
//  RecipeViewModel.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import Foundation
import SwiftUI

@MainActor
class RecipesViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private let networkClient: NetworkClientProtocol
    let imageLoader: ImageLoader

    init(networkClient: NetworkClientProtocol = NetworkClient(),
         imageLoader: ImageLoader = ImageLoader()) {
        self.networkClient = networkClient
        self.imageLoader = imageLoader
    }

    func recipes() async {
        
        isLoading = true
        errorMessage = nil


            do {
                let request = RecipeListRequest()
                let response: RecipeResponse = try await networkClient.performRequest(request: request)
                self.recipes = response.recipes
                self.isLoading = false
            } catch let networkError as NetworkError {
                 self.errorMessage = networkError.errorDescription
                 self.isLoading = false
             } catch {
                 self.errorMessage = "An unexpected error occurred."
                 self.isLoading = false
             }
        
    }

}
