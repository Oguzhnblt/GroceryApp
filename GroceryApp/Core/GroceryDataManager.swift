//
//  GroceryDataManager.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class GroceryDataManager: ObservableObject {
    @Published var products: [GroceryProducts] = []
    private var db = Firestore.firestore()

    // Genel veri çekme fonksiyonu
    private func fetchProducts(from collection: String, withField field: String? = nil, equalTo value: String? = nil) {
        var query: Query = db.collection(collection)
        if let field = field, let value = value {
            query = query.whereField(field, isEqualTo: value)
        }
        
        query.getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Ürünleri çekerken hata oluştu: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("Ürün bulunamadı")
                return
            }
            
            self.products = documents.compactMap { document in
                try? document.data(as: GroceryProducts.self)
            }
        }
    }

    func fetchAllProducts() {
        fetchProducts(from: "GroceryProducts")
    }

    func fetchProducts(forCategory category: String) {
        fetchProducts(from: "GroceryProducts", withField: "category", equalTo: category)
    }
}
