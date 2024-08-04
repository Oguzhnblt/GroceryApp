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
            let priceString = product.price.dropFirst()
            let price = Double(priceString) ?? 0.0
            return total + (price * Double(product.quantity))
        }
    }
    
    private var isCartEmpty: Bool {
        dataManager.cartProducts.isEmpty
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Divider()
                    .padding(.top, -30)
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
            }
            .scrollIndicators(.hidden)
            checkoutSection
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("My Cart")
                            .font(.custom("Gilroy-SemiBold", size: 20))
                            .foregroundStyle(.black)
                    }
                }
                .onAppear {
                    dataManager.fetchCartProducts()
                }

        }
        .sheet(isPresented: $isCheckoutPresented) {
            CheckoutView(totalPrice: totalPrice)
                .presentationDetents([.fraction(0.7)])

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
                    .foregroundColor(.clear)
                    .frame(width: 364, height: 67)
                    .background(isCartEmpty ? Color.gray.opacity(0.5) : Color(red: 0.33, green: 0.69, blue: 0.46))
                    .cornerRadius(19)
                
                HStack {
                    Text("Go to Checkout")
                        .font(Font.custom("Gilroy-SemiBold", size: 18))
                        .foregroundColor(Color(red: 0.99, green: 0.99, blue: 0.99))
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", totalPrice))")
                        .font(Font.custom("Gilroy-SemiBold", size: 14))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5))
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(4)
                }
                .padding([.leading, .trailing], 25)
            }
            .padding(.bottom, 35)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isCartEmpty)
    }
    
    struct GroceryCartView_Previews: PreviewProvider {
        static var previews: some View {
            GroceryCartView()
                .environmentObject(GroceryDataManager())
        }
    }
}
