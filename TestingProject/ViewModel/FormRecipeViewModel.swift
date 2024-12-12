//
//  FormRecipeViewModel.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 12/12/24.
//

import SwiftData
import SwiftUI

@Observable
class FormRecipeViewModel {
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}
