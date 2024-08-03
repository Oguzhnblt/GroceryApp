
//
//  DeliveryAddressView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

//
//  DeliveryAddressView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

import SwiftUI

struct DeliveryAddressView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: GroceryDataManager

    @Binding var selectedAddress: DeliveryAddress?

    @State private var newAddress: String = ""
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var zip: String = ""
    @State private var isAddingNewAddress: Bool = false
    @State private var isEditingAddress: Bool = false
    @State private var editingAddressId: String? = nil
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    private func handleAddressAction() {
        guard !newAddress.isEmpty, !city.isEmpty, !state.isEmpty, !zip.isEmpty else {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }
        
        if isEditingAddress, let editingAddressId = editingAddressId {
            // Update address logic
            dataManager.updateAddress(addressId: editingAddressId, newAddress: newAddress, city: city, state: state, zip: zip)
        } else {
            // Add new address
            let address = DeliveryAddress(
                id: nil,
                newAddress: newAddress,
                city: city,
                state: state,
                zip: zip
            )
            dataManager.addAddress(address)
        }
        
        // Reset form and state
        newAddress = ""
        city = ""
        state = ""
        zip = ""
        isAddingNewAddress = false
        isEditingAddress = false
        editingAddressId = nil
    }

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
            
            // Address List
            if dataManager.userAddresses.isEmpty {
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
                List {
                    ForEach(dataManager.userAddresses) { address in
                        HStack {
                            Text("\(address.newAddress), \(address.city), \(address.state) \(address.zip)")
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                                .padding(.vertical, 12)
                                .padding(.leading, 8)
                            Spacer()
                            if selectedAddress?.id == address.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                                    .padding(.trailing)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedAddress = address
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                dataManager.removeAddress(addressId: address.id!)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                isEditingAddress = true
                                isAddingNewAddress = true
                                editingAddressId = address.id
                                newAddress = address.newAddress
                                city = address.city
                                state = address.state
                                zip = address.zip
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(Color(red: 0.33, green: 0.69, blue: 0.46))
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            
            Divider()
            
            // New/Edit Address Section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: {
                        if isEditingAddress {
                            isEditingAddress = false
                            isAddingNewAddress = false
                            newAddress = ""
                            city = ""
                            state = ""
                            zip = ""
                        } else {
                            isAddingNewAddress.toggle()
                        }
                    }) {
                        Text(isAddingNewAddress ? "Cancel" : "Add New Address")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.white)
                    
                    if isAddingNewAddress {
                        Button(action: handleAddressAction) {
                            Text(isEditingAddress ? "Save Changes" : "Save Address")
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

                            TextField("ZIP Code", text: $zip)
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
        .onAppear {
            dataManager.fetchUserAddresses()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Missing Information"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
