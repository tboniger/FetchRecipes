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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await viewModel.recipes()
        }
    }
}

#Preview {
    RecipeListView()
}
