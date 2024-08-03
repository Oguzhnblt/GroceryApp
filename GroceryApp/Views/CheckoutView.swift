//
//  CheckoutView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var showAddressSheet = false
    @State private var showCardSheet = false
    @State private var selectedAddress: DeliveryAddress? = nil
    @State private var selectedCard: CreditCard? = nil
    
    var totalPrice: Double
    
    private var formattedCardNumber: String {
        guard let card = selectedCard else { return "Select Card" }
        let lastFourDigits = card.cardNumber.suffix(4)
        let maskedCardNumber = "**** **** **** \(lastFourDigits)"
        return maskedCardNumber
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Checkout")
                .font(.custom("Gilroy-SemiBold", size: 24))
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                .padding([.leading, .bottom])
            
            Divider()
            
            // Delivery Address Section
            HStack {
                Button(action: {
                    showAddressSheet.toggle()
                }) {
                    HStack {
                        Text("Delivery Address")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        Spacer()
                        Text(selectedAddress?.newAddress ?? "Select address")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            
            Divider()
            
            // Payment Section
            HStack {
                Button(action: {
                    showCardSheet.toggle()
                }) {
                    HStack {
                        Text("Payment")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        Spacer()
                        Text(formattedCardNumber)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            .lineLimit(1)
                        Image("card")
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            
            Divider()
            
            // Promo Code Section
            HStack {
                Button(action: {
                    // Promo code action
                }) {
                    HStack {
                        Text("Promo Code")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        Spacer()
                        Image(systemName: "barcode")
                            .foregroundColor(.black)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
            
            Divider()
            
            // Total Cost Section
            HStack {
                Text("Total Cost")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                Spacer()
                Text("$\(String(format: "%.2f", totalPrice))")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
            }
            .padding()
            
            Button(action: {
                // Place order action
            }) {
                Text("Place Order")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                    .cornerRadius(8)
            }
            .padding()
            
        }
        .sheet(isPresented: $showAddressSheet) {
            DeliveryAddressView(selectedAddress: $selectedAddress)
        }
        .sheet(isPresented: $showCardSheet) {
            PaymentCardView(selectedCard: $selectedCard)
        }
    }
}
