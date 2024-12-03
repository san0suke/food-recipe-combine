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
    
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
