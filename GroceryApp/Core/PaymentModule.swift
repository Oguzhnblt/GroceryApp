//
//  PaymentSDK.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 3.08.2024.
//

import Foundation

class PaymentModule {
    static let shared = PaymentModule()
    
    private init() {}
    
    func startPayment(cardNo: String, expDate: String, cvv: String, amount: Double, callback: @escaping (Result<Void, PaymentError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let isValidCardNo = cardNo.digitsOnly.count == 16
            let isValidExpDate = expDate.formattedExpirationDate().count == 5
            let isValidCVV = cvv.digitsOnly.count == 3
            let isAmountValid = amount > 0
            
            if isValidCardNo && isValidExpDate && isValidCVV && isAmountValid {
                callback(.success(()))
            } else {
                callback(.failure(.invalidCardDetails))
            }
        }
    }
    
    func confirmPayment(otp: String, callback: @escaping (Result<Void, PaymentError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if otp == "123456" {
                callback(.success(()))
            } else {
                callback(.failure(.invalidOTP))
            }
        }
    }
    
    enum PaymentError: LocalizedError {
        case invalidCardDetails
        case invalidOTP
        
        var errorDescription: String? {
            switch self {
            case .invalidCardDetails:
                return "The card details provided are invalid. Please check your card number, expiration date, and CVV."
            case .invalidOTP:
                return "The OTP provided is incorrect. Please check the OTP and try again."
            }
        }
    }
}
