//
//  CartView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI

struct GroceryCartView: View {
    @StateObject private var dataManager = GroceryDataManager()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    if dataManager.products.filter({ $0.isAdded }).isEmpty {
                        EmptyCardView(title: "Oops! Your Cart Is Empty", message: "Continue searching for products to add to your cart.")
                    } else {
                        ForEach(dataManager.products.filter { $0.isAdded }, id: \.id) { product in
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
        let cartRef = dataManager.db.collection("Cart").document(productId)
        
        cartRef.delete { error in
            if let error = error {
                print("Error removing product from cart: \(error.localizedDescription)")
            } else {
                print("Product removed from cart successfully.")
                dataManager.fetchCartProducts()
            }
        }
    }
}

struct GroceryCartView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryCartView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
