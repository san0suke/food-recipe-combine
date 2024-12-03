//
//  IngredientsView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

struct IngredientsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var ingredients: [RecipeIngredient]
    
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
    }
    
    private func addItem() {
        print("add")
    }
}

#Preview {
    IngredientsView()
}
