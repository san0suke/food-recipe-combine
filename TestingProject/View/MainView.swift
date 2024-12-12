//
//  MainView.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: IngredientsView(modelContext: modelContext)) {
                    MenuButton(title: "Ingredients", icon: "leaf")
                }
                NavigationLink(destination: FoodRecipesView(modelContext: modelContext)) {
                    MenuButton(title: "Food Recipes", icon: "book")
                }
            }
            .padding()
            .navigationTitle("Food App")
        }
    }
}

#Preview {
    MainView()
}
