//
//  ProductCardView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI

struct ProductCardView: View {
    var product: GroceryProducts
    var updateProduct: (GroceryProducts) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 18).foregroundColor(.white))
                    .frame(width: 173.32, height: 248.51)
                
                VStack(alignment: .leading) {
                    Image(product.imageName!)
                        .resizable()
                        .frame(width: 99.89, height: 79.43)
                    
                    Text(product.name)
                        .font(Font.custom("Gilroy-Bold", size: 16))
                        .tracking(0.10)
                        .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                        .padding(.top, 14.70)
                    
                    Text(product.title)
                        .font(Font.custom("Gilroy-Medium", size: 14))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        .padding(.top, 0.5)
                    
                    HStack(spacing: 45) {
                        Text(product.price)
                            .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                            .tracking(0.10)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            .padding(.top, 10)
                        
                        Button(action: {
                            var newProduct = product
                            newProduct.isAdded.toggle()
                            updateProduct(newProduct)
                        }) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 45.67, height: 45.67)
                                    .background(Color(red: 0, green: 0.70, blue: 0.44))
                                    .cornerRadius(17)
                            }
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .cornerRadius(17)
                            .overlay(
                                Image(systemName: product.isAdded ? "checkmark" : "plus")
                                    .foregroundColor(.white)
                            )
                        }
                    }
                    .padding(.top, 30)
                }
            }
        }
        .frame(width: 173, height: 249)
        .background(Color.white)
    }
}


//#Preview {
//    ProductCardView(
//        product: GroceryProducts(name: "Sample Product", title: "1kg, Priceg", imageName: "sampleImage", price: "$4.99", details: "", nutrition: []),
//            updateProduct: { _ in }
//        )}
