//
//  GroceryDataManager.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class GroceryDataManager: ObservableObject {
    
    @Published var products: [GroceryProducts] = []
    @Published var cartProducts: [GroceryProducts] = []
    
    var db = Firestore.firestore()
    
    
    func fetchProducts(from collection: String, withField field: String? = nil, equalTo value: String? = nil) {
        var query: Query = db.collection(collection)
        if let field = field, let value = value {
            query = query.whereField(field, isEqualTo: value)
        }
        
        query.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching products: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No products found")
                return
            }
            
            if collection == "Cart" {
                self.cartProducts = documents.compactMap { document in
                    try? document.data(as: GroceryProducts.self)
                }
            } else {
                self.products = documents.compactMap { document in
                    try? document.data(as: GroceryProducts.self)
                }
            }
        }
    }
    
    func fetchAllProducts() {
        fetchProducts(from: "GroceryProducts")
    }
    
    func fetchCartProducts() {
        fetchProducts(from: "Cart")
    }
    
    func fetchProducts(forCategory category: String) {
        fetchProducts(from: "GroceryProducts", withField: "category", equalTo: category)
    }
    
    func addToCart(product: GroceryProducts, quantity: Int) {
        guard let productId = product.id else { return }
        let cartRef = db.collection("Cart").document(productId)
        
        cartRef.setData([
            "name": product.name,
            "title": product.title,
            "price": product.price,
            "quantity": quantity,
            "imageName": product.imageName ?? "",
            "details": product.details,
            "isAdded": true,
            "category": product.category
        ]) { [weak self] error in
            if let error = error {
                print("Error adding product to cart: \(error.localizedDescription)")
            } else {
                print("Product added to cart successfully.")
                self?.fetchCartProducts()
            }
        }
    }
    
    func removeFromCart(productId: String) {
        let cartRef = db.collection("Cart").document(productId)
        
        cartRef.delete { [weak self] error in
            if let error = error {
                print("Error removing product from cart: \(error.localizedDescription)")
            } else {
                print("Product removed from cart successfully.")
                self?.fetchCartProducts()
            }
        }
    }
    
    func updateCartProductQuantity(productId: String, newQuantity: Int) {
        let cartRef = db.collection("Cart").document(productId)
        
        cartRef.updateData(["quantity": newQuantity]) { [weak self] error in
            if let error = error {
                print("Error updating product quantity: \(error.localizedDescription)")
            } else {
                print("Product quantity updated successfully.")
                self?.fetchCartProducts()
            }
        }
    }
    
    func fetchOrderHistory() {
        fetchProducts(from: "Orders")
    }
    
    //    func addOrder(order: Order) {
    //        guard let orderId = order.id else { return }
    //        let orderRef = db.collection("Orders").document(orderId)
    //
    //        orderRef.setData([
    //            "customerName": order.customerName,
    //            "orderDate": order.orderDate,
    //            "products": order.products.map { product in
    //                [
    //                    "id": product.id ?? "",
    //                    "name": product.name,
    //                    "quantity": product.quantity
    //                ]
    //            }
    //        ]) { [weak self] error in
    //            if let error = error {
    //                print("Error adding order to history: \(error.localizedDescription)")
    //            } else {
    //                print("Order added to history successfully.")
    //                self?.fetchOrderHistory() // Update order history
    //            }
    //        }
    //    }
}
