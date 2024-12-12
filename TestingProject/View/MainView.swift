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
                Text("Food App")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                NavigationLink(destination: IngredientsView()) {
                    MenuButton(title: "Ingredients", icon: "leaf")
                }
                NavigationLink(destination: FoodRecipesView()) {
                    MenuButton(title: "Food Recipes", icon: "book")
                }
                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MainView()
}
