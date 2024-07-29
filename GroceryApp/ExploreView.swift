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
        ("vegfruit", "Fresh Fruits\n& Vegetables", Color(red: 0.33, green: 0.69, blue: 0.46)),
        ("dairy", "Dairy & Eggs", Color(red: 0.85, green: 0.85, blue: 0.85)),
        ("meat", "Meat & Fish", Color(red: 0.97, green: 0.65, blue: 0.58)),
        ("oil", "Cooking Oil", Color(red: 0.97, green: 0.64, blue: 0.30)),
        ("bakery", "Bakery & Snacks", Color(red: 0.83, green: 0.69, blue: 0.88)),
        ("beverages", "Beverages", Color(red: 0.72, green: 0.87, blue: 0.96))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                SearchField(searchText: $searchText, placeholder: "Search categories")
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(categories, id: \.0) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCell(
                                imageName: category.0,
                                title: category.1,
                                backgroundColor: category.2,
                                borderColor: category.2
                            )
                        }
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Explore")
                        .font(.custom("Gilroy-Bold", size: 20))
                }
            }
        }
    }
}

struct CategoryDetailView: View {
    let category: (String, String, Color)
    
    var body: some View {
        VStack {
            Text(category.1)
                .font(.largeTitle)
                .foregroundColor(category.2)
                .padding()
            // Add more details about the category here
            Spacer()
        }
        .navigationTitle(category.1)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ExploreView()
}
