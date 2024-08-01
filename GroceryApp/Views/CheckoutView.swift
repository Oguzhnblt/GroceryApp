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
    @State private var selectedAddress: String? = nil
    @State private var selectedCard: String? = nil
    @State private var addresses: [String] = ["123 Main St", "456 Elm St"]
    @State private var cards: [String] = ["**** **** **** 1234", "**** **** **** 5678"]
    var totalPrice: Double
    
    
    var formattedCardNumber: String {
        guard let card = selectedCard else { return "Select Card" }
        let lastFourDigits = card.suffix(4)
        let maskedCardNumber = String(repeating: "*", count: 4) + " " + lastFourDigits
        return maskedCardNumber
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Checkout")
                .font(Font.custom("Gilroy-SemiBold", size: 24))
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
                        Text(selectedAddress ?? "Select")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            .lineLimit(1)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
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
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
            
            Divider()
            
            // Promo Code Section
            HStack {
                Button(action: {}, label: {
                    HStack {
                        Text("Promo Code")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        Spacer()
                        Image(systemName: "barcode")
                            .foregroundStyle(.black)
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                })
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
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
            .padding()
        }
        .padding([.leading, .trailing])
        .sheet(isPresented: $showAddressSheet) {
            DeliveryAddressView(selectedAddress: $selectedAddress, addresses: $addresses)
                .presentationDetents([.fraction(0.6)])
        }
        .sheet(isPresented: $showCardSheet) {
            PaymentCardView(selectedCard: $selectedCard, cards: $cards)
                .presentationDetents([.fraction(0.6)])
        }
    }
}



#Preview {
    CheckoutView(totalPrice: 1)
}

