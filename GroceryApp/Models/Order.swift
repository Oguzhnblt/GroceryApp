//
//  Order.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct Order: Codable, Identifiable {
    @DocumentID var id: String?
    var products: [GroceryProducts]
    var totalPrice: Double
    var orderDate: Date
}
