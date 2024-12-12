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
    
    func deleteRecipes(at indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                modelContext.delete(foodRecipes[index])
            }
            
            do {
                try modelContext.save()
                fetchFoodRecipes()
            } catch {
                print("Error on deleting: \(error.localizedDescription)")
            }
        }
    }
}
