//
//  IngredientsSelectionViewModel.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 12/12/24.
//

import Foundation

class IngredientsSelectionViewModel: ObservableObject {
    @Published var ingredients: [RecipeIngredient]
    @Published var selectedIngredients: [RecipeIngredient]
    private var initialIngredients: [RecipeIngredient] = []

    init(ingredients: [RecipeIngredient], selectedIngredients: [RecipeIngredient]) {
        self.ingredients = ingredients
        self.selectedIngredients = selectedIngredients
        self.initialIngredients = selectedIngredients
    }

    func addIngredient(_ ingredient: RecipeIngredient) {
        if let index = selectedIngredients.firstIndex(where: { $0.id == ingredient.id }) {
            selectedIngredients.remove(at: index)
        } else {
            selectedIngredients.append(ingredient)
        }
    }

    func cancelSelection() {
        selectedIngredients = initialIngredients
    }

    func saveSelection() {
        initialIngredients = selectedIngredients
    }
}
