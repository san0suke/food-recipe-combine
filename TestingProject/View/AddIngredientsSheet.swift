//
//  AddIngredientsSheet.swift
//  TestingProject
//
//  Created by Robson Cesar de Siqueira on 03/12/24.
//

import SwiftUI

struct AddIngredientsSheet: View {
    
    @Binding var isPresented: Bool
    @Binding var name: String
    var onSave: () -> Void
    
    var body: some View {
        VStack {
            Text("Add Ingredients")
                .font(.title)
                .padding()
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .frame(maxWidth: .infinity)

                Button(action: {
                    onSave()
                    isPresented = false
                }) {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!name.isEmpty ? Color.blue : Color.blue.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(name.isEmpty)
                .frame(maxWidth: .infinity)
            }
            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
}

#Preview {
    AddIngredientsSheet(isPresented: .constant(false),
                        name: .constant("")) {}
}
