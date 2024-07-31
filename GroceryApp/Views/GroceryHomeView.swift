//
//  GroceryHomeView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct GroceryHomeView: View {
    @StateObject var dataManager = GroceryDataManager()
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
                    
                    if filteredProducts.isEmpty {
                        EmptyCardView(
                            title: "No Products Found",
                            message: "Try adjusting your search or browsing our categories."
                        )
                    } else {
                        if !exclusiveOfferProducts.isEmpty {
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
                        }
                        
                        if !bestSellingProducts.isEmpty {
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
                }
            }
            .padding(.bottom, 30)
            .background(Color.clear)
            .onAppear {
                dataManager.fetchAllProducts()
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
        .ignoresSafeArea()
}
