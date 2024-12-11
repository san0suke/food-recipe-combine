//
//  FoodRecipesView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct FoodRecipesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FoodRecipe.name, order: .forward) private var foodRecipes: [FoodRecipe]
    
    var body: some View {
        VStack {
            List(foodRecipes) { recipe in
                NavigationLink(destination: FormRecipeView(recipe: recipe)) {
                    Text(recipe.name)
                }
            }
        }
        .navigationTitle("Food Recipes")
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: FormRecipeView()) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    FoodRecipesView()
}
