//
//  GroceryProducts.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import Foundation
import FirebaseFirestoreSwift

struct GroceryProducts: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let title: String
    var imageName: String?
    let price: String
    let details: String
    var isAdded: Bool = false
    var quantity: Int

    struct NutritionInfo: Codable {
        let label: String
        let value: String
    }

    let nutrition: [String: String]?
    let category: String
}
