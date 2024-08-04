//
//  CheckoutView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    @State private var showAddressSheet = false
    @State private var showCardSheet = false
    @State private var showPaymentResult = false
    @State private var showOTPInput = false
    @State private var paymentMessage: String = ""
    @State private var selectedAddress: DeliveryAddress? = nil
    @State private var selectedCard: CreditCard? = nil
    @State private var otp = ["", "", "", "", "", ""]
    @State private var showOrderAccepted = false
    
    var totalPrice: Double
    
    private var formattedCardNumber: String {
        guard let card = selectedCard else { return "Select Card" }
        let lastFourDigits = card.cardNumber.suffix(4)
        let maskedCardNumber = "**** **** **** \(lastFourDigits)"
        return maskedCardNumber
    }
    
    var body: some View {
        ZStack {
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
                    Task {
                        await startPaymentProcess()
                    }
                }) {
                    GroceryButton(text: "Place Order")
                        .padding(.top, 10)
                }
                .padding()
            }
            
            // OTP View
            if showOTPInput {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                OTPInputView(otp: $otp) {
                    Task {
                        await confirmPaymentProcess()
                    }
                }
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
        .sheet(isPresented: $showAddressSheet) {
            DeliveryAddressView(selectedAddress: $selectedAddress)
                .presentationDetents([.fraction(0.8)])
        }
        .sheet(isPresented: $showCardSheet) {
            PaymentCardView(selectedCard: $selectedCard)
                .presentationDetents([.fraction(0.8)])
        }
        .alert(isPresented: $showPaymentResult) {
            Alert(
                title: Text("Payment Status"),
                message: Text(paymentMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $showOrderAccepted, onDismiss: {
            presentationMode.wrappedValue.dismiss()
        }) {
            OrderAcceptedView()
        }
    }
    
    private func startPaymentProcess() async {
        guard selectedAddress != nil else {
            paymentMessage = "Please select a delivery address."
            showPaymentResult = true
            return
        }
        
        guard let card = selectedCard else {
            paymentMessage = "Please select a payment card."
            showPaymentResult = true
            return
        }
        
        do {
            try await PaymentModule.shared.startPayment(cardNo: card.cardNumber, expDate: card.expirationDate, cvv: card.cvv, amount: totalPrice)
            withAnimation {
                otp = ["", "", "", "", "", ""]
                showOTPInput = true
            }
        } catch {
            paymentMessage = error.localizedDescription
            showPaymentResult = true
            showOTPInput = false
        }
    }
    
    private func confirmPaymentProcess() async {
        let otpString = otp.joined()
        
        do {
            try await PaymentModule.shared.confirmPayment(otp: otpString)
            dataManager.placeOrder(products: dataManager.cartProducts, totalPrice: totalPrice)
            dataManager.removeAllFromCart()
            dismissViews()
        } catch {
            paymentMessage = error.localizedDescription
            showPaymentResult = true
            showOTPInput = false
        }
    }

    private func dismissViews() {
        showOTPInput = false
        showOrderAccepted = true
    }
}
