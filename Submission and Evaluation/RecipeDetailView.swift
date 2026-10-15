//
//  RecipeDetailView.swift
//  Submission and Evaluation
//
//  Created by Əsli Namazova on 14.10.26.
//

import SwiftUI

struct RecipeDetailView: View {
    @State private var recipe: Recipe
    let onFavoriteChanged: (UUID, Bool) -> Void

    init(recipe: Recipe, onFavoriteChanged: @escaping (UUID, Bool) -> Void) {
        _recipe = State(initialValue: recipe)
        self.onFavoriteChanged = onFavoriteChanged
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                recipeImage
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .accessibilityLabel("Photo of \(recipe.name)")

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()

                Text(recipe.description)
                    .font(.body)
                    .foregroundStyle(.secondary)

                HStack(spacing: 8) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(recipe.isFavorite ? .red : .gray)
                    Text(recipe.isFavorite ? "Favorite: Yes ❤️" : "Favorite: No")
                        .font(.headline)
                }
                .accessibilityElement(children: .combine)

                Divider()

                Text("Ingredients")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        Label(ingredient, systemImage: "checkmark.circle")
                    }
                }

                Button {
                    recipe.isFavorite.toggle()
                    onFavoriteChanged(recipe.id, recipe.isFavorite)
                } label: {
                    Label(recipe.isFavorite ? "Remove from Favorites" : "Add to Favorites",
                          systemImage: recipe.isFavorite ? "heart.fill" : "heart")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(recipe.isFavorite ? .red : .blue)
                .controlSize(.large)
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
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
                .padding(60)
                .foregroundStyle(.gray)
                .background(Color(.systemGray5))
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            recipe: Recipe(name: "Pancakes",
                           description: "Fluffy breakfast pancakes served with maple syrup.",
                           ingredients: ["Flour", "Milk", "Eggs"],
                           imageName: "pancakes"),
            onFavoriteChanged: { _, _ in }
        )
    }
}
