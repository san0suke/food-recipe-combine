//
//  RecipeIngredient.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import Foundation
import SwiftData

@Model
final class RecipeIngredient {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
