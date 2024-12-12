//
//  FormRecipeViewModel.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 12/12/24.
//

import SwiftData
import SwiftUI

class FormRecipeViewModel: ObservableObject {
    
    private var modelContext: ModelContext?
    private var dismiss: DismissAction?
    private var recipe: FoodRecipe?
    
    @Published var name: String = ""
    @Published var selectedIngredients: [RecipeIngredient] = []
    @Published var showAddIngredientsSheet: Bool = false
    @Published var ingredients: [RecipeIngredient] = []
    
    func initialize(modelContext: ModelContext,
                    dismiss: DismissAction,
                    recipe: FoodRecipe?) {
        self.modelContext = modelContext
        self.dismiss = dismiss
        self.recipe = recipe
        
        setupForm()
        fetchRecipeIngredients()
    }
    
    func fetchRecipeIngredients() {
        guard let modelContext = modelContext else { return }
        
        let fetchDescriptor = FetchDescriptor<RecipeIngredient>(
            sortBy: [SortDescriptor(\.name)]
        )
        
        do {
            ingredients = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch ingredients: \(error)")
            ingredients = []
        }
    }
    
    func saveRecipe() {
        guard let modelContext = modelContext,
            let dismiss = dismiss else { return }
        
        if let recipe = recipe {
            recipe.name = name
            recipe.ingredients = selectedIngredients
        } else {
            let newRecipe = FoodRecipe(name: name, ingredients: selectedIngredients)
            modelContext.insert(newRecipe)
        }
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func removeIngredient(_ ingredient: RecipeIngredient) {
        selectedIngredients.removeAll { $0.id == ingredient.id }
    }
    
    private func setupForm() {
        if let recipe = recipe {
            name = recipe.name
            selectedIngredients = Array(recipe.ingredients)
        }
    }
}
