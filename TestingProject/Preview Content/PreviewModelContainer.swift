//
//  PreviewModelContainer.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 12/12/24.
//

import SwiftUI
import SwiftData

@MainActor
final class PreviewModelContainer {
    
    static let instance = PreviewModelContainer()
    let container: ModelContainer
    let modelContext: ModelContext
    
    private init() {
        let schema = Schema([
            RecipeIngredient.self,
            FoodRecipe.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            self.container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.modelContext = container.mainContext
            
            configureFoodRecipePreviewData()
            configureIngredientsPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func configureFoodRecipePreviewData() {
        if let existingRecipes = try? modelContext.fetch(FetchDescriptor<FoodRecipe>()) {
            for recipe in existingRecipes {
                modelContext.delete(recipe)
            }
        }
        
        let ingredient1 = RecipeIngredient(name: "Tomato")
        let ingredient2 = RecipeIngredient(name: "Pasta")
        let recipe = FoodRecipe(name: "Spaghetti Bolognese", ingredients: [ingredient1, ingredient2])
        
        modelContext.insert(recipe)
    }
    
    private func configureIngredientsPreviewData() {
        if let existingRecipes = try? modelContext.fetch(FetchDescriptor<RecipeIngredient>()) {
            for recipe in existingRecipes {
                modelContext.delete(recipe)
            }
        }
        
        let ingredient = RecipeIngredient(name: "Tomato")
        modelContext.insert(ingredient)
    }
}
