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
    
    @StateObject private var viewModel = FormRecipeViewModel()
    
    var recipe: FoodRecipe?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Enter Recipe Name", text: $viewModel.name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                
                Section(header: Text("Ingredients")) {
                    if viewModel.selectedIngredients.isEmpty {
                        Text("No Ingredients selected.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(viewModel.selectedIngredients) { ingredient in
                            HStack {
                                Text(ingredient.name)
                                Spacer()
                                Button(action: {
                                    viewModel.removeIngredient(ingredient)
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        viewModel.showAddIngredientsSheet.toggle()
                    }) {
                        Label("Add Ingredient", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showAddIngredientsSheet) {
                IngredientsSelectionView(ingredients: viewModel.ingredients,
                                         selectedIngredients: $viewModel.selectedIngredients)
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
                        viewModel.saveRecipe()
                    }
                    .disabled(viewModel.name.isEmpty || viewModel.selectedIngredients.isEmpty)
                }
            }
            .onAppear {
                viewModel.initialize(modelContext: modelContext,
                                     dismiss: dismiss,
                                     recipe: recipe)
            }
        }
    }
}

#Preview {
    FormRecipeView()
}
