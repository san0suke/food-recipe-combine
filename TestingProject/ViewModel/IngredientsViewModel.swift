//
//  IngredientsViewModel.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 11/12/24.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class IngredientsViewModel: ObservableObject {
    
    private var modelContext: ModelContext?
    
    var ingredientName: String = ""
    var selectedIngredient: RecipeIngredient?
    var showFormAlert: Bool = false
    
    private(set) var ingredients: [RecipeIngredient] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchIngredients()
    }
    
    func fetchIngredients() {
        guard let modelContext else { return }
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
    
    func addItem() {
        ingredientName = ""
        selectedIngredient = nil
        showFormAlert = true
    }
    
    func saveIngredient() {
        withAnimation {
            if let selectedIngredient = selectedIngredient {
                selectedIngredient.name = ingredientName
            } else {
                let ingredient = RecipeIngredient(name: ingredientName)
                modelContext?.insert(ingredient)
            }
            
            do {
                try modelContext?.save()
                resetForm()
                fetchIngredients()
            } catch {
                print("Error on saving: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteIngredients(at indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                modelContext?.delete(ingredients[index])
            }
            
            do {
                try modelContext?.save()
                fetchIngredients()
            } catch {
                print("Error on deleting: \(error.localizedDescription)")
            }
        }
    }
    
    private func resetForm() {
        ingredientName = ""
        selectedIngredient = nil
        showFormAlert = false
    }
}
