//
//  IngredientsView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
    
    @StateObject private var viewModel: IngredientsViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = IngredientsViewModel(modelContext: modelContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.ingredients) { ingredient in
                Button(action: {
                    viewModel.configure(with: ingredient)
                }) {
                    Text(ingredient.name)
                        .foregroundColor(Color.primary)
                }
            }
            .onDelete(perform: viewModel.deleteIngredients)
        }
        .toolbar {
            ToolbarItem {
                Button(action: viewModel.addItem) {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Ingredients")
        .sheet(isPresented: $viewModel.showFormAlert) {
            FormIngredientsSheet(isPresented: $viewModel.showFormAlert,
                                 name: $viewModel.ingredientName,
                                 selectedIngredient: $viewModel.selectedIngredient) {
                viewModel.saveIngredient()
            }
        }
    }
}

#Preview {
    IngredientsView(modelContext: PreviewModelContainer.instance.modelContext)
}
