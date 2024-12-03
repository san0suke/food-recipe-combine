//
//  Item.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
