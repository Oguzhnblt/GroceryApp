//
//  DeliveryAddressView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

import SwiftUI

import SwiftUI

struct DeliveryAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedAddress: String?
    @Binding var addresses: [String]
    
    @State private var newAddress: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zipCode: String = ""
    @State private var isAddingNewAddress: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("Delivery Address")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
            }
            .padding(.top)

            Divider()

            // Address List or Warning
            if addresses.isEmpty {
                VStack {
                    Image(systemName: "location.slash")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                    Text("No addresses available")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(addresses, id: \.self) { address in
                            HStack {
                                if selectedAddress == address {
                                    HStack {
                                        Text(address)
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                            .padding(.vertical, 12)
                                            .padding(.leading, 8)
                                        Spacer()
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                                            .padding(.trailing)
                                    }
                                    .background(Color(red: 0.33, green: 0.69, blue: 0.46).opacity(0.2))
                                    .cornerRadius(8)
                                } else {
                                    HStack {
                                        Text(address)
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                            .padding(.vertical, 12)
                                            .padding(.leading, 8)
                                        Spacer()
                                        Circle()
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing, 18)
                                    }
                                    .background(Color.white)
                                    .cornerRadius(8)
                                }
                                Button(action: {
                                    // Remove the address
                                    if let index = addresses.firstIndex(of: address) {
                                        addresses.remove(at: index)
                                        // Deselect the address if it was removed
                                        if selectedAddress == address {
                                            selectedAddress = nil
                                        }
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.black)
                                        .padding(.trailing)
                                }
                            }
                            .onTapGesture {
                                selectedAddress = address
                            }
                            Divider()
                        }
                    }
                }
            }

            Divider()

            // New Address Section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: {
                        isAddingNewAddress.toggle()
                    }) {
                        Text(isAddingNewAddress ? "Cancel" : "Add New Address")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.white)
                    
                    if isAddingNewAddress {
                        Button(action: {
                            if !newAddress.isEmpty && !city.isEmpty && !state.isEmpty && !zipCode.isEmpty {
                                let fullAddress = "\(newAddress), \(city), \(state) \(zipCode)"
                                addresses.append(fullAddress)
                                selectedAddress = fullAddress
                                newAddress = ""
                                city = ""
                                state = ""
                                zipCode = ""
                                isAddingNewAddress = false
                            }
                        }) {
                            Text("Add Address")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                                .cornerRadius(8)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
                
                if isAddingNewAddress {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Street Address", text: $newAddress)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        TextField("City", text: $city)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        HStack(spacing: 8) {
                            TextField("State", text: $state)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)

                            TextField("ZIP Code", text: $zipCode)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}
