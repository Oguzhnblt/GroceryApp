//
//  CartManager.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI
import Combine

class CartManager: ObservableObject {
    @Published var cartItems: [GroceryProducts] = []

    func addItem(_ item: GroceryProducts) {
        if !cartItems.contains(where: { $0.id == item.id }) {
            var newItem = item
            newItem.isAdded = true
            cartItems.append(newItem)
        }
    }

    func removeItem(_ item: GroceryProducts) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].isAdded = false
            cartItems.remove(at: index)
        }
    }

    func isItemInCart(_ item: GroceryProducts) -> Bool {
        return cartItems.contains(where: { $0.id == item.id })
    }
}
