//
//  CartView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI

struct GroceryCartView: View {
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    @State private var isCheckoutPresented = false
    
    private var totalPrice: Double {
        dataManager.cartProducts.reduce(0) { total, product in
            let price = product.price
            return total + (price * Double(product.quantity))
        }
    }
    
    private var isCartEmpty: Bool {
        dataManager.cartProducts.isEmpty
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        if isCartEmpty {
                            EmptyCardView(title: "Oops! Your Cart is Empty", message: "Continue searching for products to add to your cart.")
                        } else {
                            ForEach(dataManager.cartProducts) { product in
                                CartItemView(product: product, removeFromCartAction: {
                                    removeFromCart(product: product)
                                })
                            }
                        }
                    }
                    .padding(.bottom, 25)
                }
                .scrollIndicators(.hidden)
                
                checkoutSection
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 35)
            }
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dataManager.fetchCartProducts()
            }
            .sheet(isPresented: $isCheckoutPresented) {
                CheckoutView(totalPrice: totalPrice)
                    .presentationDetents([.fraction(0.7)])
            }
        }
    }
    
    private func removeFromCart(product: GroceryProducts) {
        guard let productId = product.id else { return }
        dataManager.removeFromCart(productId: productId)
    }
    
    private var checkoutSection: some View {
        Button(action: {
            isCheckoutPresented = true
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(isCartEmpty ? Color.gray.opacity(0.5) : AppColors.appleGreen)
                    .frame(height: 60)
                    .cornerRadius(20)
                
                HStack {
                    Text("Go to Checkout")
                        .font(AppFonts.gilroySemiBold(size: 18))
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", totalPrice))")
                        .font(AppFonts.gilroySemiBold(size: 14))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(4)
                }
                .padding([.leading, .trailing], 25)
            }
        }
        .disabled(isCartEmpty)
    }
}

struct GroceryCartView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryCartView()
            .environmentObject(GroceryDataManager())
    }
}
