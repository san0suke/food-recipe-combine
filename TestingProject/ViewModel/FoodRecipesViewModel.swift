//
//  FoodRecipesViewModel.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 11/12/24.
//

import SwiftUI
import SwiftData

@Observable
class FoodRecipesViewModel {
    
    private var modelContext: ModelContext
    
    private(set) var foodRecipes: [FoodRecipe] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchFoodRecipes()
    }
    
    func fetchFoodRecipes() {
        let fetchDescriptor = FetchDescriptor<FoodRecipe>(
            sortBy: [SortDescriptor(\.name)]
        )
        
        do {
            foodRecipes = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch ingredients: \(error)")
            foodRecipes = []
        }
    }
}
