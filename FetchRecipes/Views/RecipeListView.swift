//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading")
                } else if viewModel.recipes.isEmpty {
                    VStack {
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        } else {
                            Text("No recipes available")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                        }
                        Button {
                            Task {
                                await viewModel.recipes()
                            }
                        } label: {
                            Text("Try again")
                                .foregroundColor(.blue)
                        }
                    }
                } else {
                    List(viewModel.recipes, id: \.uuid) { recipe in
                        RecipeRowView(recipe: recipe, imageLoader: viewModel.imageLoader)
                            .listRowInsets(EdgeInsets())
                            .padding(.vertical, 8)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.recipes()
            }
        }
    }
}

#Preview {
    RecipeListView()
}
