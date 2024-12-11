//
//  FormRecipeView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 04/12/24.
//

import SwiftUI
import SwiftData

struct FormRecipeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecipeIngredient.name, order: .forward) private var ingredients: [RecipeIngredient]
    @State private var name: String = ""
    @State private var selectedIngredients: [RecipeIngredient] = []
    @State private var showAddIngredientsSheet: Bool = false
    
    var body: some View {
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
                .navigationTitle("New Recipe")
                .sheet(isPresented: $showAddIngredientsSheet) {
                    IngredientsSelectionView(ingredients: ingredients, selectedIngredients: $selectedIngredients)
                }
            }
        }
    }
    
    private func removeIngredient(_ ingredient: RecipeIngredient) {
        selectedIngredients.removeAll { $0.id == ingredient.id }
    }
}

#Preview {
    FormRecipeView()
}
