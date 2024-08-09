//
//  GroceryHomeView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct GroceryHomeView: View {
    @EnvironmentObject var dataManager: GroceryDataManager
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
                    searchField
                    CarouselView()
                    productSections
                }
            }
            .padding(.bottom, 25)
            .onAppear {
                dataManager.fetchAllProducts()
            }
        }
    }
    
    private var searchField: some View {
        SearchField(searchText: $searchText, placeholder: "Search products")
    }
    
    @ViewBuilder
    private var productSections: some View {
        if filteredProducts.isEmpty {
            EmptyCardView(
                title: "No Products Found",
                message: "Try adjusting your search or browsing our categories."
            )
        } else {
            exclusiveOfferSection
            bestSellingSection
        }
    }
    
    @ViewBuilder
    private var exclusiveOfferSection: some View {
        if !exclusiveOfferProducts.isEmpty {
            SectionHeaderView(title: "Exclusive Offer")
            horizontalProductScroll(products: exclusiveOfferProducts)
        }
    }
    
    @ViewBuilder
    private var bestSellingSection: some View {
        if !bestSellingProducts.isEmpty {
            SectionHeaderView(title: "Best Selling")
            horizontalProductScroll(products: bestSellingProducts)
        }
    }
    
    private func horizontalProductScroll(products: [GroceryProducts]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(products) { product in
                    NavigationLink(destination: GroceryProductDetailView(product: product)) {
                        ProductCardView(product: product)
                    }
                }
                .padding(.leading)
            }
        }
    }
}

