//
//  IngredientsView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
    
    @State private var viewModel: IngredientsViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = IngredientsViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.ingredients) { ingredient in
                Button(action: {
                    viewModel.selectedIngredient = ingredient
                    viewModel.ingredientName = ingredient.name
                    viewModel.showFormAlert = true
                }) {
                    HStack {
                        Text(ingredient.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
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

//#Preview {
//    IngredientsView(modelContext: )
//        .modelContainer(for: RecipeIngredient.self, inMemory: true)
//}
