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

    init() {
        fetchProducts()
    }

    func fetchProducts() {
        db.collection("GroceryProducts").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return } // Güvenli erişim

            if let error = error { // Hata kontrolü
                print("Ürünleri çekerken hata oluştu: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else { 
                print("Ürün bulunamadı")
                return
            }

            do {
                self.products = try documents.compactMap { document in
                    try document.data(as: GroceryProducts.self)
                }
            } catch {
                print("Ürünleri decode ederken hata oluştu: \(error.localizedDescription)")
            }
        }
    }
}
