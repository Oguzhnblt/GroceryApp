//
//  GroceryHomeView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct GroceryProducts: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let imageName: String
    let price: String
    var isAdded: Bool = false
}

struct GroceryHomeView: View {
    
    @State private var searchText = ""
    @State private var products = [
        GroceryProducts(name: "Organic Bananas", title: "7pcs, Priceg", imageName: "banana", price: "$4.99"),
        GroceryProducts(name: "Red Apple", title: "1kg, Priceg", imageName: "apple", price: "$4.99"),
        GroceryProducts(name: "Red Pepper", title: "1kg, Priceg", imageName: "pepper", price: "$3.99"),
        GroceryProducts(name: "Broccoli", title: "1kg, Priceg", imageName: "broccoli", price: "$2.99")
    ]
    
    var filteredProducts: [GroceryProducts] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // Search bar and location
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.gray)
                        Text("İstanbul, Kadıköy")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "bell.fill")
                            .foregroundColor(.gray)
                    }
                    .padding([.leading, .trailing, .top])
                    
                    // Search field
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.leading)
                        TextField("Search foods", text: $searchText)
                            .padding(.leading, 1)
                    }
                    .frame(height: 40)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding([.leading, .trailing, .top])
                    
                    // Banner
                    CarouselView()
                    
                    // Exclusive Offer section
                    SectionHeaderView(title: "Exclusive Offer")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filteredProducts) { product in
                                ProductCardView(product: product, updateProduct: self.updateProduct)
                            }
                        }
                        .padding(.leading)
                    }
                    
                    // Best Selling section
                    SectionHeaderView(title: "Best Selling")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(filteredProducts) { product in
                                ProductCardView(product: product, updateProduct: self.updateProduct)
                            }
                        }
                        .padding(.leading)
                    }
                }
            }
            .navigationBarHidden(true)
            .background(Color.white)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func updateProduct(_ updatedProduct: GroceryProducts) {
        if let index = products.firstIndex(where: { $0.id == updatedProduct.id }) {
            products[index] = updatedProduct
        }
    }
}

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Button {
                // "Action in here
            } label: {
                Text("See all")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding([.leading, .trailing, .top])
        
        
    }
}

struct CarouselView: View {
    let banners = ["freshveg1", "freshveg2", "freshveg3"]
    
    var body: some View {
        TabView {
            ForEach(banners, id: \.self) { banner in
                Image(banner)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .frame(height: 150)
        .tabViewStyle(PageTabViewStyle())
        .padding()
    }
}


struct ProductCardView: View {
    var product: GroceryProducts
    var updateProduct: (GroceryProducts) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 18).foregroundColor(.white))
                    .frame(width: 173.32, height: 248.51)
                
                VStack {
                    Image(product.imageName)
                        .resizable()
                        .frame(width: 99.89, height: 79.43)
                    
                    Text(product.name)
                        .font(Font.custom("Gilroy-Bold", size: 16))
                        .tracking(0.10)
                        .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                        .padding(.top, 14.70)
                    
                    Text(product.title)
                        .font(Font.custom("Gilroy-Medium", size: 14))
                        .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        .padding(.top, 0.5)
                    
                    HStack(spacing: 45) {
                        Text(product.price)
                            .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                            .tracking(0.10)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            .padding(.top, 10)
                        
                        Button(action: {
                            var newProduct = product
                            newProduct.isAdded.toggle()
                            updateProduct(newProduct)
                        }) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 45.67, height: 45.67)
                                    .background(Color(red: 0, green: 0.70, blue: 0.44))
                                    .cornerRadius(17)
                            }
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .cornerRadius(17)
                            .overlay(
                                Image(systemName: product.isAdded ? "checkmark" : "plus")
                                    .foregroundColor(.white)
                            )
                        }
                    }
                    .padding(.top, 30)
                }
            }
        }
        .frame(width: 173, height: 249)
        .background(Color.white)
    }
}

#Preview {
    GroceryHomeView()
}
