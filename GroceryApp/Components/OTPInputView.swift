//
//  OTPInputView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import SwiftUI

struct OTPInputView: View {
    @Binding var otp: [String]
    var onConfirm: () -> Void
    
    @FocusState private var focusedField: Int?
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Enter OTP")
                .font(Font.custom("Gilroy-SemiBold", size: 20))
                .tracking(0.10)
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            
            HStack(spacing: 10) {
                ForEach(0..<6) { index in
                    TextField("", text: $otp[index])
                        .frame(width: 40, height: 40)
                        .font(Font.custom("Gilroy-SemiBold", size: 14))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: index)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1))
                        .onChange(of: otp[index]) { _,newValue in
                            if newValue.count > 1 {
                                otp[index] = String(newValue.last!)
                            }
                            if newValue.count == 1 {
                                focusedField = index < 5 ? index + 1 : nil
                            } else if newValue.isEmpty && index > 0 {
                                focusedField = index - 1
                            }
                        }
                }
            }
            
            Button(action: {
                onConfirm()
            }) {
                GroceryButton(text: "Verify")
            }
            .padding(.top, 20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .onAppear {
            focusedField = 0
        }
    }
}
