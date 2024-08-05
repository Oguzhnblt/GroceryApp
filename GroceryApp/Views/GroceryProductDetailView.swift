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
    private var pricePerUnit: Double
    
    @EnvironmentObject private var dataManager: GroceryDataManager
    @Environment(\.isTabBarHidden) private var isTabBarHidden
    
    @State private var isProductInCart: Bool = false
    
    init(product: GroceryProducts) {
        self.product = product
        self.pricePerUnit = Double(product.price)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Group {
                    if let imageURL = imageURL {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(height: 250)
                            case .success(let image):
                                image
                                    .resizable()
                                    .foregroundStyle(.clear)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 250)
                                    .frame(maxWidth: .infinity)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 250)
                                    .cornerRadius(15)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        ProgressView()
                            .frame(height: 250)
                            .cornerRadius(15)
                            .onAppear {
                                if !isImageLoaded {
                                    fetchImageURL(imageName: product.imageName!)
                                }
                            }
                    }
                }
                
                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(product.name)
                            .font(Font.custom("Gilroy-Bold", size: 24))
                            .tracking(0.10)
                            .lineSpacing(18)
                            .foregroundColor(AppColors.darkGreen)
                        
                        Text(product.title)
                            .font(Font.custom("Gilroy-Medium", size: 16))
                            .foregroundColor(AppColors.oliveGreen)
                    }
                    
                    HStack {
                        ItemCounter(quantity: $quantity, minQuantity: 1, maxQuantity: 5)
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
                        
                        Text("$\(String(format: "%.2f", pricePerUnit * Double(quantity)))")
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

struct GroceryProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = GroceryProducts(
            id: "1",
            name: "Sample Product",
            title: "This is a sample product description",
            imageName: "sample_image",
            price: 9.99,
            details: "This is a detailed description of the sample product.", isAdded: true,
            quantity: 12, nutrition: [
                "Calories": "200 kcal",
                "Protein": "10 g",
                "Fat": "5 g",
                "Carbohydrates": "30 g"
            ],
            category: "fresh"
        )
        
        GroceryProductDetailView(product: sampleProduct)
            .previewLayout(.sizeThatFits)
            .padding()
            .ignoresSafeArea()
            .environmentObject(GroceryDataManager())
    }
}
