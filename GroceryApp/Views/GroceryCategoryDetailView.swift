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
        VStack {
            if dataManager.products.isEmpty {
                Text("Loading...")
                    .font(AppFonts.gilroyMedium(size: 20))
                    .foregroundColor(category.2)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(dataManager.products) { product in
                            NavigationLink(destination: GroceryProductDetailView(product: product)) {
                                ProductCardView(product: product)
                            }
                        }
                    }
                    .padding([.leading, .trailing])
                    .padding(.bottom, 35)
                }
            }
        }
        .onAppear {
            dataManager.fetchProducts(forCategory: category.0)
        }
        .navigationTitle(category.1)
        .navigationBarTitleDisplayMode(.inline)
        .customBackButton()
    }
}

#Preview {
    GroceryCategoryDetailView(category: ("Sample", "Sample", .green))
}
