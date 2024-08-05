//
//  GroceryButton.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import SwiftUI

struct GroceryButton: View {
    var text: String
    var backgroundColor: Color? = AppColors.appleGreen


    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 353, height: 67)
                .background(backgroundColor)
                .cornerRadius(19)
            Text(text)
                .font(Font.custom("Gilroy-SemiBold", size: 18))
                .lineSpacing(18)
                .foregroundColor(Color(red: 1, green: 0.98, blue: 1))
        }
        .frame(width: 353, height: 67)
    }
}

#Preview {
    GroceryButton(text: "Button")
}

