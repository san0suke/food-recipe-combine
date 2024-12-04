//
//  TestingProjectApp.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI
import SwiftData

@main
struct TestingProjectApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            RecipeIngredient.self,
            FoodRecipe.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
//            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
