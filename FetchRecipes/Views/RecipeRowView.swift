//
//  RecipeRowView.swift
//  FetchRecipes
//
//  Created by Timothy Böniger on 10/19/24.
//

import SwiftUI

struct RecipeRowView: View {
    
    let recipe: Recipe
    let imageLoader: ImageLoader
    @State private var image: UIImage? = nil
    @Environment(\.openURL) private var openURL

    var body: some View {
        HStack(alignment: .top, spacing: 16) {

            ZStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay(
                            ProgressView()
                        )
                }
            }
            .frame(width: 80, height: 80)
            .cornerRadius(8)
            .clipped()
            .task {
                await loadImage()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                HStack {
                    if let sourceUrl = recipe.sourceUrl, !sourceUrl.isEmpty, let url = URL(string: sourceUrl) {
                        Text("View Recipe")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .onTapGesture {
                                openURL(url)
                            }
                        Spacer().frame(width: 25)
                    }
                    if let youTubeUrl = recipe.youtubeUrl, !youTubeUrl.isEmpty, let url = URL(string: youTubeUrl) {
                        Text("View Video")
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .onTapGesture {
                                openURL(url)
                            }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }

    func loadImage() async {
        image = await imageLoader.loadImage(from: recipe.photoUrlSmall)
    }

}

#Preview {
    RecipeRowView(recipe: .init(cuisine: "British", name: "Bakewell Tart", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "eed6005f-f8c8-451f-98d0-4088e2b40eb6", sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ", youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"), imageLoader: ImageLoader())
}

