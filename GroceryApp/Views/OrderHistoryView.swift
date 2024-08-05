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
                    EmptyCardView(title: "No Orders Yet", message: "You haven't placed any orders so far. Start shopping to create your order history.")
                } else {
                    List {
                        ForEach(dataManager.orderHistory) { order in
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Order Date: \(order.date, formatter: DateFormatter.shortDate)")
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    ForEach(order.products, id: \.name) { product in
                                        HStack {
                                            Text("\(product.name) x \(product.quantity)")
                                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                            Spacer()
                                            let price = product.price
                                            let totalPrice = price * Double(product.quantity)
                                            Text("$\(String(format: "%.2f", totalPrice))")
                                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                        }
                                    }
                                }
                                
                                DashedLine()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .frame(height: 1)
                                    .padding(.vertical, 5)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    let subtotal = order.totalPrice / 1.08
                                    let tax = order.totalPrice - subtotal
                                    
                                    HStack {
                                        Text("Subtotal:")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                                        Spacer()
                                        Text("$\(String(format: "%.2f", subtotal))")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                                    }
                                    HStack {
                                        Text("Tax (8%):")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                                        Spacer()
                                        Text("$\(String(format: "%.2f", tax))")
                                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                                    }
                                    DashedLine()
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .frame(height: 1)
                                }
                                
                                HStack {
                                    Spacer()
                                    Text("Total: $\(String(format: "%.2f", order.totalPrice))")
                                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                                }
                                .padding(.top, 5)
                                
                                Text("Thank you for your purchase!")
                                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                                    .italic()
                                    .padding(.top, 10)
                            }
                            .padding()
                            .background(Color.white) // Background color for receipt appearance
                            .border(Color.black, width: 1) // Border to resemble receipt
                            .cornerRadius(8)
                            .padding(.vertical, 5)
                        }
                    }
                }
            }
            .navigationTitle("Order History")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dataManager.fetchOrderHistory()
            }
        }
    }
}

struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}
