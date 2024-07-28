//
//  TabbarView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI

struct TabbarView: View {    
    var body: some View {
        TabView {
            GroceryHomeView()
                .tabItem {
                    Label("Shop", image: "home")
                }
            
            ExploreView()
                .tabItem {
                    Label("Explore", image: "explore")
                }
            
            GroceryProductDetailView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}


