//
//  CartView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI

struct GroceryCartView: View {
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if dataManager.cartProducts.isEmpty {
                        EmptyCardView(title: "Oops! Your Cart is Empty", message: "Continue searching for products to add to your cart.")
                    } else {
                        ForEach(dataManager.cartProducts) { product in
                            CartItemView(product: product, removeFromCartAction: {
                                removeFromCart(product: product)
                            })
                        }
                    }
                }
                .padding(.top, 30)
            }
        }
        .onAppear {
            dataManager.fetchCartProducts()
        }
    }
    
    private func removeFromCart(product: GroceryProducts) {
        guard let productId = product.id else { return }
        dataManager.removeFromCart(productId: productId)
    }
}

