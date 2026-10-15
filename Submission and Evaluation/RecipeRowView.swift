//
//  RecipeRowView.swift
//  Submission and Evaluation
//
//  Created by Əsli Namazova on 14.10.26.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    let onFavoriteChanged: (UUID, Bool) -> Void

    var body: some View {
        HStack(spacing: 12) {
            NavigationLink {
                RecipeDetailView(recipe: recipe, onFavoriteChanged: onFavoriteChanged)
            } label: {
                HStack(spacing: 12) {
                    recipeImage
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.name)
                            .font(.headline)
                        Text(recipe.description)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Button {
                onFavoriteChanged(recipe.id, !recipe.isFavorite)
            } label: {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(recipe.isFavorite ? .red : .gray)
                    .font(.title3)
                    .frame(width: 36, height: 44)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(recipe.isFavorite ? "Remove from Favorites" : "Add to Favorites")
        }
        .padding(.vertical, 4)
    }

    @ViewBuilder
    private var recipeImage: some View {
        if let uiImage = UIImage(named: recipe.imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .padding(14)
                .foregroundStyle(.gray)
                .background(Color(.systemGray5))
        }
    }
}

#Preview {
    RecipeRowView(
        recipe: Recipe(name: "Pancakes",
                       description: "Fluffy breakfast pancakes served with maple syrup.",
                       ingredients: ["Flour", "Milk", "Eggs"],
                       imageName: "pancakes"),
        onFavoriteChanged: { _, _ in }
    )
    .padding()
}
