//
//  CustomBackButton.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 31.07.2024.
//

import SwiftUI

struct CustomBackButton: ViewModifier {
    @Environment(\.presentationMode) var presentationMode

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
    }
}

extension View {
    func groceryBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
}
