//
//  MenuButton.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI

struct MenuButton: View {
    
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    MenuButton(title: "Button", icon: "star")
}
