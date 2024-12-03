//
//  FoodRecipe.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import Foundation
import SwiftData

@Model
final class FoodRecipe {
    
    var name: String
    @Relationship var ingredients: [RecipeIngredient]
    
    init(name: String, ingredients: [RecipeIngredient]) {
        self.name = name
        self.ingredients = ingredients
    }
}
