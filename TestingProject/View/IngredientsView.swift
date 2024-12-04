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
    @Query private var ingredients: [RecipeIngredient]
    
    @State private var showFormAlert: Bool = false
    @State private var ingredientName: String = ""
    
    var body: some View {
        List {
            ForEach(ingredients) { ingredient in
                Text(ingredient.name)
            }
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
            AddIngredientsSheet(isPresented: $showFormAlert, name: $ingredientName) {
                saveIngredient()
            }
        }
    }
    
    private func addItem() {
        showFormAlert.toggle()
    }
    
    private func saveIngredient() {
        withAnimation {
            let ingredient = RecipeIngredient(name: ingredientName)
            modelContext.insert(ingredient)
            
            do {
                try modelContext.save()
                ingredientName = ""
            } catch {
                print("Error on saving: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    IngredientsView()
        .modelContainer(for: RecipeIngredient.self, inMemory: true)
}
