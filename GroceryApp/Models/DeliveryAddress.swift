//
//  DeliveryAddress.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 3.08.2024.
//

import FirebaseFirestoreSwift

struct DeliveryAddress: Identifiable, Codable {
    @DocumentID var id: String?
    var newAddress: String
    var city: String
    var state: String
    var zip: String
}
