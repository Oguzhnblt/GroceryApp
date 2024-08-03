//
//  GroceryProducts.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import FirebaseFirestoreSwift

struct GroceryProducts: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var name: String
    var title: String
    var imageName: String?
    var price: String
    var details: String
    var isAdded: Bool = false
    var quantity: Int

    struct NutritionInfo: Codable {
        let label: String
        let value: String
    }

    let nutrition: [String: String]?
    let category: String
}
