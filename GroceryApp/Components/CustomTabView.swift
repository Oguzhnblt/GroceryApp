//
//  TabView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI

struct CustomTabView: View {
    @State var selectedTab = "home"
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                GroceryHomeView()
                    .tag("home")
                ExploreView()
                    .tag("explore")
                GroceryCartView()
                    .tag("cart")
                OrderHistoryView()
                    .tag("orders")
                AccountView()
                    .tag("account")
            }
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { image in
                    
                    TabButon(image: image, selectedTab: $selectedTab)
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 2, y: 2)
            .shadow(color: Color.black.opacity(0.15), radius: 2, x: -2, y: -2)
            .padding(.horizontal)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct TabButon: View {
    var image : String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {selectedTab = image}) {
            Image(image)
                .renderingMode(.template)
                .foregroundStyle(selectedTab == image ? (Color(red: 0.33, green: 0.69, blue: 0.46))
                                 : Color.black.opacity(0.4))
                .padding()
        }
    }
}

var tabs = ["home", "explore", "cart", "orders","account"]

#Preview {
    CustomTabView()
}
