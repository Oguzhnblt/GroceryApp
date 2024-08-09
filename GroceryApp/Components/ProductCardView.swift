//
//  ProductCardView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI

struct ProductCardView: View {
    var product: GroceryProducts
    @State private var quantity: Int = 1
    
    @State private var isAddedToCart: Bool = false
    @State private var imageURL: URL?
    
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    init(product: GroceryProducts) {
        self.product = product
    }
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 18).foregroundColor(.white))
                    .frame(width: 173.32, height: 248.51)
                
                VStack(alignment: .leading) {
                    if let imageURL = imageURL {
                        AsyncImageView(url: imageURL, placeholder: Image(systemName: "photo"))
                            .frame(width: 99.89, height: 79.43)
                            .foregroundStyle(AppColors.appleGreen)
                    } else {
                        ProgressView()
                            .frame(width: 99.89, height: 79.43)
                            .onAppear {
                                fetchImageURL(imageName: product.imageName ?? "")
                            }
                    }
                    
                    Text(product.name)
                        .font(AppFonts.gilroyBold(size: 16))
                        .tracking(0.10)
                        .foregroundColor(AppColors.darkGreen)
                        .padding(.top, 14.70)
                    
                    Text(product.title)
                        .font(AppFonts.gilroyMedium(size: 14))
                        .foregroundColor(AppColors.oliveGreen)
                        .padding(.top, 0.5)
                    
                    HStack(spacing: 45) {
                        Text("$\(String(format: "%.2f", product.price))")
                            .font(AppFonts.gilroySemiBold(size: 18))
                            .foregroundColor(AppColors.darkGreen)
                            .padding(.top, 10)
                        
                        Button {
                            if isAddedToCart {
                                dataManager.removeFromCart(productId: product.id!)
                            } else {
                                dataManager.addToCart(product: product, quantity: quantity)
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .foregroundColor(AppColors.appleGreen)
                                    .frame(width: 40, height: 40)
                                Image(systemName: isAddedToCart ? "checkmark" : "plus")
                                    .foregroundColor(.white)
                                    .font(AppFonts.gilroySemiBold(size: 12))
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.top, 30)
                }
            }
        }
        .onChange(of: dataManager.cartProducts) {
            isAddedToCart = dataManager.cartProducts.contains(where: { $0.id == product.id })
        }
        .frame(width: 173, height: 249)
        .background(Color.white)
    }
    
    private func fetchImageURL(imageName: String) {
        FetchImageHelper.fetchImageURL(imageName: imageName) { url, error in
            if let error = error {
                print("Error getting image URL: \(error.localizedDescription)")
                return
            }
            
            if let url = url {
                DispatchQueue.main.async {
                    self.imageURL = url
                }
            }
        }
    }
}
