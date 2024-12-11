//
//  IngredientsSelectionView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 11/12/24.
//

import SwiftUI

struct IngredientsSelectionView: View {
    
    let ingredients: [RecipeIngredient]
    @Binding var selectedIngredients: [RecipeIngredient]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(ingredients) { ingredient in
                Button(action: {
                    addIngredient(ingredient)
                }) {
                    HStack {
                        Text(ingredient.name)
                        if selectedIngredients.contains(where: { $0.id == ingredient.id }) {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Select Ingredients")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func addIngredient(_ ingredient: RecipeIngredient) {
        if !selectedIngredients.contains(where: { $0.id == ingredient.id }) {
            selectedIngredients.append(ingredient)
        }
    }
}

#Preview {
    IngredientsSelectionView(ingredients: [], selectedIngredients: .constant([]))
}
