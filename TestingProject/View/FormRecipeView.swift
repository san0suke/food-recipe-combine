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
    
    var body: some View {
        Form {
            Section(header: Text("Recipe Name")) {
                TextField("Enter Recipe Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding()
            }
            
            Section(header: Text("Ingredients")) {
                
            }
        }
    }
}

#Preview {
    FormRecipeView()
}
