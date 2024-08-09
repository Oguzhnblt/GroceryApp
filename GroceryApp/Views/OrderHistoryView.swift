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
                    .padding(.bottom, 60)
                } else {
                    ScrollView() {
                        VStack(spacing: 20) {
                            ForEach(dataManager.orderHistory) { order in
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Order Date: \(order.date, formatter: DateFormatter.shortDate)")
                                        .font(AppFonts.gilroyBold(size: 16))
                                        .foregroundColor(AppColors.darkGreen)
                                        .padding(.bottom, 5)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        ForEach(order.products, id: \.name) { product in
                                            HStack {
                                                Text("\(product.name) x \(product.quantity)")
                                                    .font(AppFonts.gilroyMedium(size: 14))
                                                    .foregroundColor(AppColors.darkGreen)
                                                Spacer()
                                                let price = product.price
                                                let totalPrice = price * Double(product.quantity)
                                                Text("$\(String(format: "%.2f", totalPrice))")
                                                    .font(AppFonts.gilroyMedium(size: 14))
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
                                                .font(AppFonts.gilroyMedium(size: 14))
                                                .foregroundColor(AppColors.darkGreen)
                                            Spacer()
                                            Text("$\(String(format: "%.2f", subtotal))")
                                                .font(AppFonts.gilroyMedium(size: 14))
                                                .foregroundColor(AppColors.darkGreen)
                                        }
                                        HStack {
                                            Text("Tax (8%):")
                                                .font(AppFonts.gilroyMedium(size: 14))
                                                .foregroundColor(AppColors.darkGreen)
                                            Spacer()
                                            Text("$\(String(format: "%.2f", tax))")
                                                .font(AppFonts.gilroyMedium(size: 14))
                                                .foregroundColor(AppColors.darkGreen)
                                        }
                                        Divider()
                                            .background(Color.gray.opacity(0.5))
                                    }
                                    
                                    HStack {
                                        Spacer()
                                        Text("Total: $\(String(format: "%.2f", order.totalPrice))")
                                            .font(AppFonts.gilroyBold(size: 14))
                                            .foregroundColor(AppColors.darkGreen)
                                    }
                                    .padding(.top, 5)
                                    
                                    Text("Thank you for your purchase!")
                                        .font(AppFonts.gilroyMedium(size: 14))
                                        .foregroundColor(AppColors.darkGreen)
                                        .italic()
                                        .padding(.top, 5)
                                }
                                .padding()
                                .background(Color.white)
                                .border(Color.gray.opacity(0.5), width: 2)
                                .cornerRadius(10)
                            }
                        }
                        .padding(.bottom, 35)
                        .padding([.leading, .trailing], 15)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Order History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dataManager.fetchOrderHistory()
            }
        }
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.bottom)
    }
}
