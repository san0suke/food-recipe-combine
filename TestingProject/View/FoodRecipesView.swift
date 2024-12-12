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
    @StateObject private var viewModel = FoodRecipesViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.foodRecipes) { recipe in
                    NavigationLink(destination: FormRecipeView(recipe: recipe)) {
                        Text(recipe.name)
                    }
                }
                .onDelete(perform: viewModel.deleteRecipes)
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
        .onAppear {
            viewModel.initialize(modelContext: modelContext)
        }
    }
}

#Preview {
    FoodRecipesView()
        .modelContext(PreviewModelContainer.instance.modelContext)
}
