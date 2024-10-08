//
//  GroceryDataManager.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class GroceryDataManager: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var products: [GroceryProducts] = []
    @Published var cartProducts: [GroceryProducts] = []
    @Published var userCards: [CreditCard] = []
    @Published var userAddresses: [DeliveryAddress] = []
    @Published var orderHistory: [OrderHistory] = []
    
    
    
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    // MARK: - Product Functions
    
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
            
            let fetchedProducts = documents.compactMap { document in
                try? document.data(as: GroceryProducts.self)
            }
            
            if collection == "Cart" {
                self.cartProducts = fetchedProducts
            } else {
                self.products = fetchedProducts
            }
        }
    }
    
    func fetchCartProducts() {
        guard let userId = userId else { return }
        
        let cartRef = db.collection("Users").document(userId).collection("Cart")
        
        cartRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching cart products: \(error.localizedDescription)")
                return
            }
            
            let fetchedCartProducts = snapshot?.documents.compactMap { document in
                try? document.data(as: GroceryProducts.self)
            } ?? []
            
            self?.cartProducts = fetchedCartProducts
        }
    }
    
    func fetchAllProducts() {
        fetchProducts(from: "GroceryProducts")
    }
    
    
    func fetchProducts(forCategory category: String) {
        fetchProducts(from: "GroceryProducts", withField: "category", equalTo: category)
    }
    
    func addToCart(product: GroceryProducts, quantity: Int) {
        guard let userId = userId, let productId = product.id else { return }
        let cartRef = db.collection("Users").document(userId).collection("Cart").document(productId)
        
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
        guard let userId = userId else { return }
        let cartRef = db.collection("Users").document(userId).collection("Cart").document(productId)
        
        cartRef.delete { [weak self] error in
            if let error = error {
                print("Error removing product from cart: \(error.localizedDescription)")
            } else {
                print("Product removed from cart successfully.")
                self?.fetchCartProducts()
            }
        }
    }
    
    func removeAllFromCart() {
        guard let userId = userId else { return }
        let cartRef = db.collection("Users").document(userId).collection("Cart")
        
        cartRef.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching cart products: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No products found in cart.")
                return
            }
            
            let batch = self.db.batch()
            for document in documents {
                batch.deleteDocument(document.reference)
            }
            
            batch.commit { error in
                if let error = error {
                    print("Error removing all products from cart: \(error.localizedDescription)")
                } else {
                    print("All products removed from cart successfully.")
                    self.fetchCartProducts()
                }
            }
        }
    }
    
    
    
    func updateCartProductQuantity(productId: String, newQuantity: Int) {
        guard let userId = userId else { return }
        let cartRef = db.collection("Users").document(userId).collection("Cart").document(productId)
        
        cartRef.updateData(["quantity": newQuantity]) { [weak self] error in
            if let error = error {
                print("Error updating product quantity: \(error.localizedDescription)")
            } else {
                print("Product quantity updated successfully.")
                self?.fetchCartProducts()
            }
        }
    }
    
    // MARK: - Card Functions
    
    func addCard(cardNumber: String, cardholderName: String, expirationDate: String, cvv: String) {
        guard let userId = userId else { return }
        let cardRef = db.collection("Users").document(userId).collection("cards").document()
        
        cardRef.setData([
            "cardNumber": cardNumber,
            "cardholderName": cardholderName,
            "expirationDate": expirationDate,
            "cvv": cvv
        ]) { [weak self] error in
            if let error = error {
                print("Error adding card: \(error.localizedDescription)")
            } else {
                print("Card added successfully.")
                self?.fetchUserCards()
            }
        }
    }
    
    func removeCard(cardId: String) {
        guard let userId = userId else { return }
        let cardRef = db.collection("Users").document(userId).collection("cards").document(cardId)
        
        cardRef.delete { [weak self] error in
            if let error = error {
                print("Error removing card: \(error.localizedDescription)")
            } else {
                print("Card removed successfully.")
                self?.fetchUserCards()
            }
        }
    }
    
    func updateCard(cardId: String, cardNumber: String, cardholderName: String, expirationDate: String, cvv: String) {
        guard let userId = userId else { return }
        let cardRef = db.collection("Users").document(userId).collection("cards").document(cardId)
        
        cardRef.updateData([
            "cardNumber": cardNumber,
            "cardholderName": cardholderName,
            "expirationDate": expirationDate,
            "cvv": cvv
        ]) { [weak self] error in
            if let error = error {
                print("Error updating card: \(error.localizedDescription)")
            } else {
                print("Card updated successfully.")
                self?.fetchUserCards()
            }
        }
    }
    
    func fetchUserCards() {
        guard let userId = userId else { return }
        let cardsRef = db.collection("Users").document(userId).collection("cards")
        
        cardsRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching cards: \(error.localizedDescription)")
                return
            }
            self?.userCards = snapshot?.documents.compactMap { document in
                try? document.data(as: CreditCard.self)
            } ?? []
        }
    }
    
    // MARK: - Address Functions
    
    func addAddress(_ address: DeliveryAddress) {
        guard let userId = userId else { return }
        let addressRef = db.collection("Users").document(userId).collection("addresses").document()
        
        addressRef.setData([
            "newAddress": address.newAddress,
            "city": address.city,
            "state": address.state,
            "zip": address.zip
        ]) { [weak self] error in
            if let error = error {
                print("Error adding address: \(error.localizedDescription)")
            } else {
                print("Address added successfully.")
                self?.fetchUserAddresses()
            }
        }
    }
    
    func removeAddress(addressId: String) {
        guard let userId = userId else { return }
        let addressRef = db.collection("Users").document(userId).collection("addresses").document(addressId)
        
        addressRef.delete { [weak self] error in
            if let error = error {
                print("Error removing address: \(error.localizedDescription)")
            } else {
                print("Address removed successfully.")
                self?.fetchUserAddresses()
            }
        }
    }
    
    func updateAddress(addressId: String, newAddress: String, city: String, state: String, zip: String) {
        guard let userId = userId else { return }
        let addressRef = db.collection("Users").document(userId).collection("addresses").document(addressId)
        
        addressRef.updateData([
            "newAddress": newAddress,
            "city": city,
            "state": state,
            "zip": zip
        ]) { [weak self] error in
            if let error = error {
                print("Error updating address: \(error.localizedDescription)")
            } else {
                print("Address updated successfully.")
                self?.fetchUserAddresses()
            }
        }
    }
    
    func fetchUserAddresses() {
        guard let userId = userId else { return }
        let addressesRef = db.collection("Users").document(userId).collection("addresses")
        
        addressesRef.getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching addresses: \(error.localizedDescription)")
            } else {
                self?.userAddresses = snapshot?.documents.compactMap { document in
                    try? document.data(as: DeliveryAddress.self)
                } ?? []
            }
        }
    }
    
    func fetchOrderHistory() {
        guard let userId = userId else { return }
        let ordersRef = db.collection("Users").document(userId).collection("OrderHistory")
        
        ordersRef.order(by: "date", descending: true).getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching order history: \(error.localizedDescription)")
                return
            }
            
            self?.orderHistory = snapshot?.documents.compactMap { document in
                try? document.data(as: OrderHistory.self)
            } ?? []
        }
    }
    
    func saveOrderHistory(cartProducts: [GroceryProducts], totalPrice: Double) async {
        guard let userId = userId else { return }
        let ordersRef = db.collection("Users").document(userId).collection("OrderHistory")
        
        let products = cartProducts.map { OrderHistory.OrderProduct(name: $0.name, quantity: $0.quantity, price: Double($0.price)) }
        
        let orderHistory = OrderHistory(
            date: Date(),
            products: products,
            totalPrice: totalPrice
        )
        
        do {
            _ = try await ordersRef.addDocument(data: [
                "date": Timestamp(date: orderHistory.date),
                "products": products.map { ["name": $0.name, "quantity": $0.quantity, "price": $0.price]},
                "totalPrice": orderHistory.totalPrice
            ])
            print("Order history saved successfully.")
        } catch {
            print("Error saving order history: \(error.localizedDescription)")
        }
    }
}
