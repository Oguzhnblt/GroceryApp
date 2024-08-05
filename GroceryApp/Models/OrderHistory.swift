//
//  OrderHistory.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct OrderHistory: Identifiable, Codable {
    @DocumentID var id: String?
    var date: Date
    var products: [OrderProduct]
    var totalPrice: Double
    
    struct OrderProduct: Codable {
        var name: String
        var quantity: Int
        var price: Double
    }
}

