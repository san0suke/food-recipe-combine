//
//  IngredientsView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecipeIngredient.name, order: .forward) private var ingredients: [RecipeIngredient]
    
    @State private var showFormAlert: Bool = false
    @State private var ingredientName: String = ""
    @State private var selectedIngredient: RecipeIngredient?
    
    var body: some View {
        List {
            ForEach(ingredients) { ingredient in
                Button(action: {
                    selectedIngredient = ingredient
                    ingredientName = ingredient.name
                    showFormAlert = true
                }) {
                    HStack {
                        Text(ingredient.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
            .onDelete(perform: deleteIngredients)
        }
        .toolbar {
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Ingredients")
        .sheet(isPresented: $showFormAlert) {
            FormIngredientsSheet(isPresented: $showFormAlert,
                                 name: $ingredientName,
                                 selectedIngredient: $selectedIngredient) {
                saveIngredient()
            }
        }
    }
    
    private func addItem() {
        showFormAlert.toggle()
    }
    
    private func saveIngredient() {
        withAnimation {
            if let selectedIngredient = selectedIngredient {
                selectedIngredient.name = ingredientName
                modelContext.insert(selectedIngredient)
            } else {
                let ingredient = RecipeIngredient(name: ingredientName)
                modelContext.insert(ingredient)
            }
            
            do {
                try modelContext.save()
                ingredientName = ""
                selectedIngredient = nil
            } catch {
                print("Error on saving: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteIngredients(indexSet: IndexSet) {
        withAnimation {
            for index in indexSet {
                modelContext.delete(ingredients[index])
            }
            
            do {
                try modelContext.save()
            } catch {
                print("Error on deleting: \(error.localizedDescription)")
            }
        }

    }
}

#Preview {
    IngredientsView()
        .modelContainer(for: RecipeIngredient.self, inMemory: true)
}
