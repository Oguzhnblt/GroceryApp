//
//  OrderHistoryView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject private var dataManager: GroceryDataManager
    
    var body: some View {
        NavigationView {
            VStack {
                if dataManager.orderHistory.isEmpty {
                    EmptyCardView(
                        title: "No Orders Yet",
                        message: "You haven't placed any orders so far. Start shopping to create your order history."
                    )
                } else {
                    List {
                        ForEach(dataManager.orderHistory) { order in
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Order Date: \(order.date, formatter: DateFormatter.shortDate)")
                                    .font(Font.custom("Gilroy-Bold", size: 16))
                                    .foregroundColor(AppColors.darkGreen)
                                    .padding(.bottom, 5)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    ForEach(order.products, id: \.name) { product in
                                        HStack {
                                            Text("\(product.name) x \(product.quantity)")
                                                .font(Font.custom("Gilroy-Medium", size: 14))
                                                .foregroundColor(AppColors.darkGreen)
                                            Spacer()
                                            let price = product.price
                                            let totalPrice = price * Double(product.quantity)
                                            Text("$\(String(format: "%.2f", totalPrice))")
                                                .font(Font.custom("Gilroy-Medium", size: 14))
                                                .foregroundColor(AppColors.darkGreen)
                                        }
                                    }
                                }
                                
                                Divider()
                                    .background(Color.gray.opacity(0.5))
                                    .padding(.vertical, 5)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    let subtotal = order.totalPrice / 1.08
                                    let tax = order.totalPrice - subtotal
                                    
                                    HStack {
                                        Text("Subtotal:")
                                            .font(Font.custom("Gilroy-Medium", size: 14))
                                            .foregroundColor(AppColors.darkGreen)
                                        Spacer()
                                        Text("$\(String(format: "%.2f", subtotal))")
                                            .font(Font.custom("Gilroy-Medium", size: 14))
                                            .foregroundColor(AppColors.darkGreen)
                                    }
                                    HStack {
                                        Text("Tax (8%):")
                                            .font(Font.custom("Gilroy-Medium", size: 14))
                                            .foregroundColor(AppColors.darkGreen)
                                        Spacer()
                                        Text("$\(String(format: "%.2f", tax))")
                                            .font(Font.custom("Gilroy-Medium", size: 14))
                                            .foregroundColor(AppColors.darkGreen)
                                    }
                                    Divider()
                                        .background(Color.gray.opacity(0.5))
                                }
                                
                                HStack {
                                    Spacer()
                                    Text("Total: $\(String(format: "%.2f", order.totalPrice))")
                                        .font(Font.custom("Gilroy-Bold", size: 14))
                                        .foregroundColor(AppColors.darkGreen)
                                }
                                .padding(.top, 5)
                                
                                Text("Thank you for your purchase!")
                                    .font(Font.custom("Gilroy-Medium", size: 14))
                                    .foregroundColor(AppColors.darkGreen)
                                    .italic()
                                    .padding(.top, 5)
                            }
                            .padding()
                            .background(Color.white) // White background for the receipt
                            .border(Color.gray.opacity(0.3), width: 1) // Border to resemble a receipt
                            .cornerRadius(4) // Rounded corners for modern look
                            .shadow(color: Color.gray.opacity(0.2), radius: 2, x: 0, y: 1) // Subtle shadow for depth
                            .padding(.vertical, 5)
                        }
                    }
                    .listStyle(PlainListStyle()) // Remove default list styling
                }
            }
            .navigationTitle("Order History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dataManager.fetchOrderHistory()
            }
        }
        .background(Color.gray.opacity(0.1)) // Light gray background for the whole view
        .edgesIgnoringSafeArea(.bottom) // Extend background to bottom edge
    }
}
