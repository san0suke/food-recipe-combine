//
//  FoodRecipesViewModel.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 11/12/24.
//

import SwiftUI
import SwiftData

class FoodRecipesViewModel: ObservableObject {
    
    private var modelContext: ModelContext?
    
    @Published private(set) var foodRecipes: [FoodRecipe] = []
    
    func initialize(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchFoodRecipes()
    }
    
    func fetchFoodRecipes() {
        guard let modelContext = modelContext else { return }
        
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
        guard let modelContext = modelContext else { return }
        
        withAnimation {
            for index in indexSet {
                modelContext.delete(foodRecipes[index])
            }
            
            do {
                try modelContext.save()
            } catch {
                print("Error on deleting: \(error.localizedDescription)")
            }
        }
    }
}
