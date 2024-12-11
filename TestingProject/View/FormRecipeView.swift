//
//  FormRecipeView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 04/12/24.
//

import SwiftUI
import SwiftData

struct FormRecipeView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecipeIngredient.name, order: .forward) private var ingredients: [RecipeIngredient]
    @State private var name: String = ""
    @State private var selectedIngredients: [RecipeIngredient] = []
    @State private var showAddIngredientsSheet: Bool = false
    
    var recipe: FoodRecipe?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Enter Recipe Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                Section(header: Text("Ingredients")) {
                    if selectedIngredients.isEmpty {
                        Text("No Ingredients selected.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(selectedIngredients) { ingredient in
                            HStack {
                                Text(ingredient.name)
                                Spacer()
                                Button(action: {
                                    removeIngredient(ingredient)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        showAddIngredientsSheet.toggle()
                    }) {
                        Label("Add Ingredient", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showAddIngredientsSheet) {
                IngredientsSelectionView(ingredients: ingredients, selectedIngredients: $selectedIngredients)
            }
            .navigationTitle("New Recipe")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(name.isEmpty || selectedIngredients.isEmpty)
                }
            }
            .onAppear {
                if let recipe = recipe {
                    name = recipe.name
                    selectedIngredients = Array(recipe.ingredients)
                }
            }
        }
    }
    
    private func saveRecipe() {
        
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
    
    private func removeIngredient(_ ingredient: RecipeIngredient) {
        selectedIngredients.removeAll { $0.id == ingredient.id }
    }
}

#Preview {
    FormRecipeView()
}
