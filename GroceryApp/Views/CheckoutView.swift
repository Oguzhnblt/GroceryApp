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
    
    private var formattedCardNumber: String {
        guard let card = selectedCard else { return "Select Card" }
        let lastFourDigits = card.suffix(4)
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
                        Text(selectedAddress ?? "Select")
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
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
            .padding(25)

            Divider()
            
            // Place Order button
            Button(action: {
                // Place order action
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                        .frame(width: 364, height: 67)
                        .cornerRadius(19)
                    
                    Text("Place Order")
                        .font(.custom("Gilroy-SemiBold", size: 18))
                        .foregroundColor(Color(red: 1, green: 0.98, blue: 1))
                }
            }
            .frame(width: 364, height: 67)
            .padding(.top, 15)
        }
        .padding([.leading, .trailing])
        .sheet(isPresented: $showAddressSheet) {
            DeliveryAddressView(selectedAddress: $selectedAddress, addresses: $addresses)
                .presentationDetents([.fraction(0.7)])
        }
        .sheet(isPresented: $showCardSheet) {
            PaymentCardView(selectedCard: $selectedCard, cards: $cards)
                .presentationDetents([.fraction(0.7)])
        }
    }
}

#Preview {
    CheckoutView(totalPrice: 1)
}
