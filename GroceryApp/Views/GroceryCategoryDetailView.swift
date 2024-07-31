//
//  CategoryDetailView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI

struct GroceryCategoryDetailView: View {
    let category: (String, String, Color)
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    var body: some View {
        ZStack {
            if dataManager.products.isEmpty {
                Text("Loading...")
                    .font(.custom("Gilroy-Medium", size: 20))
                    .foregroundColor(category.2)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(dataManager.products) { product in
                            NavigationLink(destination: GroceryProductDetailView(product: product)) {
                                ProductCardView(product: product, updateProduct: self.updateProduct)
                            }
                        }
                    }
                    .padding()
                }
            }
            
            Spacer()
        }
        .onAppear {
            dataManager.fetchProducts(forCategory: category.0)
        }
        .navigationTitle(category.1)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func updateProduct(_ updatedProduct: GroceryProducts) {
        if let index = dataManager.products.firstIndex(where: { $0.id == updatedProduct.id }) {
            dataManager.products[index] = updatedProduct
        }
    }
}

#Preview {
    GroceryCategoryDetailView(category: ("Sample", "Sample", .green))
}
