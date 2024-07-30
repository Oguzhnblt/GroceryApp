//
//  ItemCounter.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI
struct ItemCounter: View {
    @Binding var quantity: Int
    let minQuantity: Int
    let maxQuantity: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 40, height: 40)
                .cornerRadius(17)
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .inset(by: 0.50)
                        .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 0.50)
                )
                .overlay(
                    Button(action: { if quantity > minQuantity { quantity -= 1 } }) {
                        Image(systemName: "minus")
                            .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                            .frame(width: 14, height: 14)
                    }
                )
            Text("\(quantity)")
                .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 40, height: 40)
                .cornerRadius(17)
                .overlay(
                    RoundedRectangle(cornerRadius: 17)
                        .inset(by: 0.50)
                        .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 0.50)
                )
                .overlay(
                    Button(action: { if quantity < maxQuantity { quantity += 1 } }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                            .frame(width: 14, height: 14)
                    }
                )
        }
    }
}

#Preview {
    @State var sampleQuantity = 1
    return ItemCounter(quantity: $sampleQuantity, minQuantity: 0, maxQuantity: 10)
}

