//
//  OrderHistoryView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var dataManager: GroceryDataManager
    
    var body: some View {
        List(dataManager.orderHistory) { order in
            VStack(alignment: .leading) {
                Text("Order ID: \(order.id ?? "N/A")")
                Text("Total: $\(order.totalPrice, specifier: "%.2f")")
                Text("Date: \(order.orderDate, formatter: DateFormatter.shortDate)")
                ForEach(order.products, id: \.id) { product in
                    Text(product.name)
                }
            }
        }
        .onAppear {
            dataManager.fetchOrderHistory()
        }
    }
}

#Preview {
    OrderHistoryView()
}
