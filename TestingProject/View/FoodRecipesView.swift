//
//  FoodRecipesView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct FoodRecipesView: View {
    
    @State private var viewModel: FoodRecipesViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = FoodRecipesViewModel(modelContext: modelContext)
        _viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            List(viewModel.foodRecipes) { recipe in
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
        .onAppear {
            viewModel.fetchFoodRecipes()
        }
    }
}

#Preview {
    FoodRecipesView(modelContext: PreviewModelContainer.instance.modelContext)
}
