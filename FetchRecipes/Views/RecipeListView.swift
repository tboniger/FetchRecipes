//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
          NavigationView {
              Group {
                  if viewModel.isLoading {
                      ProgressView("Loading...")
                  } else if let errorMessage = viewModel.errorMessage {
                      Text("Error: \(errorMessage)")
                          .foregroundColor(.red)
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
