//
//  FoodRecipesView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct FoodRecipesView: View {
    
    @StateObject private var viewModel: FoodRecipesViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = FoodRecipesViewModel(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
    }
}

#Preview {
    FoodRecipesView(modelContext: PreviewModelContainer.instance.modelContext)
}
