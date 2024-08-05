//
//  ExploreView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText: String = ""
    
    let categories = [
        ("fresh", "Fresh", Color(red: 0.33, green: 0.69, blue: 0.46)),
        ("dairy", "Dairy & Eggs", Color(red: 0.85, green: 0.85, blue: 0.85)),
        ("meat", "Meat & Fish", Color(red: 0.97, green: 0.65, blue: 0.58)),
        ("beverages", "Beverages", Color(red: 0.72, green: 0.87, blue: 0.96))
    ]
  
    var filteredCategories: [(String, String, Color)] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter { $0.1.lowercased().contains(searchText.lowercased()) }
        }
    }
   
    var body: some View {
        NavigationView {
            ScrollView {
                SearchField(searchText: $searchText, placeholder: "Search categories")
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    if !filteredCategories.isEmpty {
                        Section(header: Text("Categories")) {
                            ForEach(filteredCategories, id: \.0) { category in
                                NavigationLink(destination: GroceryCategoryDetailView(category: category)) {
                                    CategoryCell(
                                        imageName: category.0,
                                        title: category.1,
                                        backgroundColor: category.2,
                                        borderColor: category.2
                                    )
                                }
                            }
                        }
                    }
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Explore")
                            .font(.custom("Gilroy-SemiBold", size: 20))
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ExploreView()
}
