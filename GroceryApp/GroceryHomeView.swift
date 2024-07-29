//
//  GroceryHomeView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct GroceryHomeView: View {
    @StateObject private var dataManager = GroceryDataManager()
    @State private var searchText = ""
    
    var filteredProducts: [GroceryProducts] {
        if searchText.isEmpty {
            return dataManager.products
        } else {
            return dataManager.products.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var exclusiveOfferProducts: [GroceryProducts] {
        Array(filteredProducts.prefix(3))
    }
    
    var bestSellingProducts: [GroceryProducts] {
        Array(filteredProducts.dropFirst(3).prefix(3))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Search field
                    SearchField(searchText: $searchText, placeholder: "Search products")
                    
                    // Banner
                    CarouselView()
                    
                    // Exclusive Offer section
                    SectionHeaderView(title: "Exclusive Offer")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(exclusiveOfferProducts) { product in
                                NavigationLink(destination: GroceryProductDetailView(product: product)) {
                                    ProductCardView(product: product, updateProduct: self.updateProduct)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                    
                    // Best Selling section
                    SectionHeaderView(title: "Best Selling")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(bestSellingProducts) { product in
                                NavigationLink(destination: GroceryProductDetailView(product: product)) {
                                    ProductCardView(product: product, updateProduct: self.updateProduct)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
            .navigationBarHidden(true)
            .background(Color.white)
            .onAppear {
                dataManager.fetchProducts()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func updateProduct(_ updatedProduct: GroceryProducts) {
        if let index = dataManager.products.firstIndex(where: { $0.id == updatedProduct.id }) {
            dataManager.products[index] = updatedProduct
        }
    }
}

#Preview {
    GroceryHomeView()
}
