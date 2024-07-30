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
    
    init(product: GroceryProducts) {
        self.product = product
        self.pricePerUnit = Double(product.price.dropFirst()) ?? 0.0
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
                                    .frame(width: 414, height: 371)
                            case .success(let image):
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 413.60, height: 371.44)
                                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                        .cornerRadius(25)
                                    image
                                        .resizable()
                                        .foregroundStyle(.clear)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 330, height: 200)

                                }
                                
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 414, height: 371)
                                    .cornerRadius(25)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 413.60, height: 371.44)
                        .cornerRadius(25)
                    } else {
                        ProgressView()
                            .frame(width: 413.60, height: 371.44)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .cornerRadius(25)
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
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                        
                        Text(product.title)
                            .font(Font.custom("Gilroy-Medium", size: 16).weight(.semibold))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    }
                    
                    HStack {
                        ItemCounter(quantity: $quantity, minQuantity: 1, maxQuantity: 9)
                        Spacer()
                        
                        Text("$\(String(format: "%.2f", pricePerUnit * Double(quantity)))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                    }
                }
                .padding([.leading, .trailing, .top], 25)
                
                VStack(alignment: .leading, spacing: 20) {
                    Divider()
                    
                    DisclosureGroup {
                        Text(product.details)
                            .padding(.top, 5)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                        
                        
                        
                    } label: {
                        Text("Product Detail")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
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
                            Text("Besin değerleri bulunamadı")
                        }
                        
                    } label: {
                        HStack {
                            Text("Nutritions")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            Spacer()
                            Text("100gr")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                                .padding(5)
                                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                .cornerRadius(5)
                        }
                    }
                }
                .padding([.leading, .trailing], 25)
                
                Divider()
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom)
                
                Button(action: {
                    // Sepete ekleme işlemi
                }) {
                    Text("Add To Cart")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing], 25)
                .padding(.bottom, 35)
            }
            .padding([.leading, .trailing])
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
            imageName: "sample_image", price: "$9.99",
            details: "This is a detailed description of the sample product.",
            nutrition: [
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
    }
}
