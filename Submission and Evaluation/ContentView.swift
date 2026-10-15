//
//  ContentView.swift
//  Submission and Evaluation
//
//  Created by Əsli Namazova on 14.10.26.
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let ingredients: [String]
    let imageName: String
    var isFavorite: Bool = false
}

struct ContentView: View {
    @State private var recipes: [Recipe] = [
        Recipe(name: "Spaghetti Carbonara",
               description: "A classic Roman pasta with eggs, cheese, and crispy pancetta.",
               ingredients: ["200g spaghetti", "100g pancetta", "2 eggs", "50g Parmesan", "Black pepper"],
               imageName: "carbonara"),
        Recipe(name: "Margherita Pizza",
               description: "Simple Neapolitan pizza with tomato, mozzarella, and fresh basil.",
               ingredients: ["Pizza dough", "Tomato sauce", "Mozzarella", "Fresh basil", "Olive oil"],
               imageName: "pizza"),
        Recipe(name: "Chicken Curry",
               description: "A warming, spiced curry served with rice.",
               ingredients: ["500g chicken", "Onion", "Garlic", "Curry powder", "Coconut milk"],
               imageName: "curry"),
        Recipe(name: "Caesar Salad",
               description: "Crisp romaine with creamy dressing, croutons, and Parmesan.",
               ingredients: ["Romaine lettuce", "Croutons", "Parmesan", "Caesar dressing", "Lemon"],
               imageName: "salad"),
        Recipe(name: "Pancakes",
               description: "Fluffy breakfast pancakes served with maple syrup.",
               ingredients: ["Flour", "Milk", "Eggs", "Baking powder", "Maple syrup"],
               imageName: "pancakes")
    ]

    @State private var searchText = ""

    private var filteredRecipes: [Recipe] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return recipes }
        return recipes.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredRecipes) { recipe in
                    RecipeRowView(recipe: recipe) { recipeID, isFavorite in
                        updateFavorite(for: recipeID, to: isFavorite)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Recipes")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search recipes"
            )
            .overlay {
                if filteredRecipes.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
        }
    }

    private func updateFavorite(for recipeID: UUID, to isFavorite: Bool) {
        guard let index = recipes.firstIndex(where: { $0.id == recipeID }) else { return }
        recipes[index].isFavorite = isFavorite
    }
}

#Preview {
    ContentView()
}
