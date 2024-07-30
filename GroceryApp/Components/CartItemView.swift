//
//  CartItemView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI

struct CartItemView: View {
    @State private var quantity: Int = 1
    let price: Double = 4.99
    
    var body: some View {
        HStack(alignment: .top) {
            Image("fresh")
                .resizable()
                .frame(width: 75, height: 65)
                .padding(.top)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Bell Pepper Red")
                    .font(.custom("Gilroy-Bold", size: 16))
                Text("1kg, Priceg")
                    .font(.custom("Gilroy-Medium", size: 14))
                ItemCounter(quantity: $quantity, minQuantity: 1, maxQuantity: 9)
                    .padding(.top, 13)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 45) {
                Button(action: {
                    // Remove item action
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .frame(width: 14, height: 14)
                }
                Text("$4.99")
                    .font(Font.custom("Gilroy-Bold", size: 18).weight(.semibold))
                    .tracking(0.10)
                    .lineSpacing(27)
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
            .padding([.leading, .trailing])
        }
        .padding()
        .frame(maxWidth: .infinity)
        
        Divider().padding([.leading, .trailing], 25)
    }
}

#Preview {
    CartItemView()
}
