//
//  CartItemView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 30.07.2024.
//

import SwiftUI

struct CartItemView: View {
    @EnvironmentObject private var dataManager: GroceryDataManager
    @State private var quantity: Int
    var product: GroceryProducts
    var removeFromCartAction: () -> Void
    private let maxQuantity = 5

    @State private var imageURL: URL?
    @State private var placeholderImage = Image(systemName: "photo")

    init(product: GroceryProducts, removeFromCartAction: @escaping () -> Void) {
        self.product = product
        self.removeFromCartAction = removeFromCartAction
        _quantity = State(initialValue: product.quantity)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 30) {
            if let imageURL = imageURL {
                AsyncImageView(url: imageURL, placeholder: placeholderImage)
                    .frame(width: 85, height: 85)
                    .padding(.top)
            } else {
                ProgressView()
                    .frame(width: 85, height: 85)
                    .padding(.top)
                    .onAppear {
                        fetchImageURL(imageName: product.imageName ?? "")
                    }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .font(.custom("Gilroy-Bold", size: 16))
                Text(product.title)
                    .font(.custom("Gilroy-Medium", size: 14))
                ItemCounter(quantity: $quantity, minQuantity: 1, maxQuantity: maxQuantity)
                    .onChange(of: quantity) { _, newQuantity in
                        if newQuantity > 0 {
                            dataManager.updateCartProductQuantity(productId: product.id!, newQuantity: newQuantity)
                        }
                    }
                    .padding(.top, 13)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onAppear {
                if let cartProduct = dataManager.cartProducts.first(where: { $0.id == product.id }) {
                    quantity = cartProduct.quantity
                }
            }

            VStack(alignment: .trailing, spacing: 50) {
                Button(action: {
                    removeFromCartAction()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .frame(width: 14, height: 14)
                }
                Text("$\(String(format: "%.2f", (Double(product.price.dropFirst()) ?? 0.0) * Double(quantity)))")
                    .font(Font.custom("Gilroy-Bold", size: 18).weight(.semibold))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
            .padding(.trailing, 15)
        }
        .padding()
        .padding(.top, 10)
        .frame(maxWidth: .infinity, alignment: .leading)

        Divider().padding([.leading, .trailing], 25)
    }

    private func fetchImageURL(imageName: String) {
        FetchImageHelper.fetchImageURL(imageName: imageName) { url, error in
            if let error = error {
                print("Error getting image URL: \(error.localizedDescription)")
                return
            }

            if let url = url {
                self.imageURL = url
            }
        }
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(
            product: GroceryProducts(id: "1", name: "Sample Product", title: "Product Title", imageName: "sample_image", price: "$10.00", details: "", isAdded: true, quantity: 1, nutrition: [:], category: ""),
            removeFromCartAction: {}
        )
        .environmentObject(GroceryDataManager())
    }
}
