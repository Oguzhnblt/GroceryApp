//
//  PaymentSDK.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 3.08.2024.
//

// PaymentSDK.swift
// GroceryApp
//
// Created by Oğuzhan Bolat on 3.08.2024.
//

import Foundation

public class PaymentModule {
    public static let shared = PaymentModule()
    
    private init() {}
    
    public func startPayment(cardNo: String, expDate: String, cvv: String, amount: Double) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        let isValidCardNo = cardNo.digitsOnly.count == 16
        let isValidExpDate = expDate.formattedExpirationDate().count == 5
        let isValidCVV = cvv.digitsOnly.count == 3
        let isAmountValid = amount > 0
        
        if !isValidCardNo || !isValidExpDate || !isValidCVV || !isAmountValid {
            throw PaymentError.invalidCardDetails
        }
    }
    
    public func confirmPayment(otp: String) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        if otp != "123456" {
            throw PaymentError.invalidOTP
        }
    }
    
    public enum PaymentError: LocalizedError {
        case invalidCardDetails
        case invalidOTP
        
        public var errorDescription: String? {
            switch self {
            case .invalidCardDetails:
                return "The card details provided are invalid. Please check your card number, expiration date, and CVV."
            case .invalidOTP:
                return "The OTP provided is incorrect. Please check the OTP and try again."
            }
        }
    }
}

