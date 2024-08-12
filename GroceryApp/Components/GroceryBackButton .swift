//
//  GroceryBackButton.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 6.08.2024.
//

import SwiftUI

struct GroceryBackButton: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    var color: Color? = AppColors.appleGreen
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(color)
                    }
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(GroceryBackButton())
    }
}
