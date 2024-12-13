//
//  IngredientsSelectionView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 11/12/24.
//
import SwiftUI

struct IngredientsSelectionView: View {
    
    @StateObject private var viewModel: IngredientsSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedIngredients: [RecipeIngredient]

    init(ingredients: [RecipeIngredient], selectedIngredients: Binding<[RecipeIngredient]>) {
        _viewModel = StateObject(wrappedValue: IngredientsSelectionViewModel(ingredients: ingredients, selectedIngredients: selectedIngredients.wrappedValue))
        _selectedIngredients = selectedIngredients
    }

    var body: some View {
        NavigationView {
            List(viewModel.ingredients) { ingredient in
                Button(action: {
                    viewModel.addIngredient(ingredient)
                }) {
                    HStack {
                        Text(ingredient.name)
                        if viewModel.selectedIngredients.contains(where: { $0.id == ingredient.id }) {
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
                        viewModel.cancelSelection()
                        selectedIngredients = viewModel.selectedIngredients
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        viewModel.saveSelection()
                        selectedIngredients = viewModel.selectedIngredients
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    IngredientsSelectionView(ingredients: [], selectedIngredients: .constant([]))
}
