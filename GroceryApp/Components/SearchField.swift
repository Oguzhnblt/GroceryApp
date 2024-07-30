//
//  SearchField.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct SearchField: View {
    @Binding var searchText: String
    var placeholder: String = "Search"

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading)
            TextField(placeholder, text: $searchText)
                .padding(.leading, 1)
        }
        .frame(height: 40)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding([.leading, .trailing, .top])
    }
}

