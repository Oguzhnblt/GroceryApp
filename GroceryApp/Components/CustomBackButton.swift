//
//  CustomBackButton.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 31.07.2024.
//

import SwiftUI

struct CustomBackButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                Text("Back")
                    .font(Font.custom("Gilroy", size: 16))
            }
            .foregroundColor(.blue) // Customize the color here
        }
    }
}

