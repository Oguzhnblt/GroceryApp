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
                .font(AppFonts.gilroySemiBold(size: 20))
                .tracking(0.10)
                .foregroundColor(AppColors.darkGreen)
            
            HStack(spacing: 10) {
                ForEach(0..<6) { index in
                    TextField("", text: $otp[index])
                        .frame(width: 40, height: 40)
                        .font(AppFonts.gilroySemiBold(size: 14))
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: index)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1))
                        .onChange(of: otp[index]) { _,newValue in
                            let cleanedValue = String(newValue.prefix(1))
                            otp[index] = cleanedValue
                            if cleanedValue.isEmpty && index > 0 {
                                focusedField = index - 1
                            } else if !cleanedValue.isEmpty && index < 5 {
                                focusedField = index + 1
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

struct OTPInputView_Previews: PreviewProvider {
    static var previews: some View {
        OTPInputView(otp: .constant(["", "", "", "", "", ""])) {
            // Action when OTP is confirmed
        }
    }
}
