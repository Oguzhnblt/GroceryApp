//
//  CheckoutView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

import SwiftUI

struct CheckoutView: View {
    @State private var showAddressSheet = false
    @State private var selectedAddress: String? = nil
    @State private var addresses: [String] = ["123 Main St", "456 Elm St"]
    
    var body: some View {
        VStack {
            // Delivery section
            HStack() {
                Button(action: {
                    showAddressSheet.toggle()
                }, label: {
                    Text("Delivery Address")
                        .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    Spacer()
                    Text(selectedAddress ?? "Select")
                        .font(Font.custom("Gilroy", size: 16).weight(.semibold))
                        .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
            }
            .padding()
            
            Divider()
            
            // Payment section
            HStack() {
                Button(action: {}, label: {
                    Text("Payment")
                        .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    Spacer()
                    Image("card")
                        .foregroundStyle(.black)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
            }
            .padding()
            
            Divider()
            
            // Promo Code section
            HStack() {
                Button(action: {}, label: {
                    Text("Promo Code")
                        .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    Spacer()
                    Image(systemName: "barcode")
                        .foregroundStyle(.black)
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.black)
                })
            }
            .padding()
            
            Divider()
            
            // Total Cost section
            HStack() {
                Text("Total Cost")
                    .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                Spacer()
                Text("$13.97")
                    .font(Font.custom("Gilroy", size: 16).weight(.semibold))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
            .padding()
        }
        .padding([.leading, .trailing])
        .sheet(isPresented: $showAddressSheet) {
            DeliveryAddressView(selectedAddress: $selectedAddress, addresses: $addresses)
        }
    }
}

#Preview {
    CheckoutView()
}
