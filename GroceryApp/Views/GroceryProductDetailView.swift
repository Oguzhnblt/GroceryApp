//
//  GroceryProductDetailView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI
import FirebaseStorage

struct GroceryProductDetailView: View {
    var product: GroceryProducts
    @State private var quantity = 1
    
    @State private var imageURL: URL?
    @State private var isImageLoaded = false
    
    
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    @State private var isProductInCart: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Group {
                    if let imageURL = imageURL {
                        AsyncImageView(url: imageURL, placeholder: Image(systemName: "photo"))
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .foregroundStyle(.green)
                    } else {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                            .frame(height: 250)
                            .onAppear {
                                fetchImageURL(imageName: product.imageName ?? "")
                            }
                    }
                }
                
                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(product.name)
                            .font(AppFonts.gilroyBold(size: 24))
                            .tracking(0.10)
                            .lineSpacing(18)
                            .foregroundColor(AppColors.darkGreen)
                        
                        Text(product.title)
                            .font(AppFonts.gilroyMedium(size: 16))
                            .foregroundColor(AppColors.oliveGreen)
                    }
                    
                    HStack {
                        ItemCounter(quantity: $quantity)
                            .onAppear() {
                                if let cartProduct = dataManager.cartProducts.first(where: { $0.id == product.id }) {
                                    quantity = cartProduct.quantity
                                    isProductInCart = true
                                } else {
                                    isProductInCart = false
                                }
                            }
                            .onChange(of: quantity) { _, newQuantity in
                                dataManager.updateCartProductQuantity(productId: product.id!, newQuantity: newQuantity)
                            }
                        
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", product.price * Double(quantity)))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(AppColors.darkGreen)
                    }
                }
                .padding(.top)
                
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    
                    DisclosureGroup {
                        Text(product.details)
                            .padding(.top, 5)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(AppColors.oliveGreen)
                        
                    } label: {
                        Text("Product Detail")
                            .font(.headline)
                            .foregroundColor(AppColors.darkGreen)
                    }
                    
                    Divider()
                    
                    DisclosureGroup {
                        if let nutrition = product.nutrition {
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(nutrition.keys.sorted(), id: \.self) { key in
                                    NutritionRow(label: key, value: nutrition[key]!)
                                }
                            }
                            .padding(.top, 10)
                        } else {
                            Text("Nutrition information not available")
                        }
                        
                    } label: {
                        HStack {
                            Text("Nutritions")
                                .font(.headline)
                                .foregroundColor(AppColors.darkGreen)
                            Spacer()
                            Text("100gr")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                                .padding(5)
                                .background(AppColors.lightGrayGreen)
                                .cornerRadius(5)
                        }
                    }
                }
                
                Divider()
                    .padding(.bottom)
                
                Button(action: {
                    if !isProductInCart {
                        dataManager.addToCart(product: product, quantity: quantity)
                        isProductInCart = true
                    }
                }) {
                    GroceryButton(
                        text: isProductInCart ? "Added To Cart" : "Add To Cart",
                        backgroundColor: isProductInCart ? AppColors.lightGrayGreen : AppColors.appleGreen
                    )
                }
                .padding(.bottom, 25)
                .disabled(isProductInCart)
            }
            .navigationBarBackButtonHidden(true)
            .customBackButton()
            .padding([.leading, .trailing])
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
    
    func fetchImageURL(imageName: String) {
        FetchImageHelper.fetchImageURL(imageName: imageName) { url, error in
            if let error = error {
                print("Error getting image URL: \(error.localizedDescription)")
                return
            }
            
            if let url = url {
                FetchImageHelper.fetchImageWithCache(url: url) { image in
                    if image != nil {
                        DispatchQueue.main.async {
                            self.imageURL = url
                            self.isImageLoaded = true
                        }
                    } else {
                        print("Failed to fetch image with cache.")
                    }
                }
            }
        }
    }
}

struct NutritionRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
        Divider()
    }
}
