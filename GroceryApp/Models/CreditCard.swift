//
//  CreditCard.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 3.08.2024.
//

import FirebaseFirestoreSwift

struct CreditCard: Identifiable, Codable {
    @DocumentID var id: String?
    var cardNumber: String
    var cardholderName: String
    var expirationDate: String
    var cvv: String
}
