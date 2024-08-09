//
//  TabView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI

struct CustomTabView: View {
    @State var selectedTab = "home"
    @State private var isTabBarHidden: Bool = false
    
    var tabs = ["home", "explore", "cart", "orders", "account"]

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                GroceryHomeView()
                    .tag(tabs[0])
                ExploreView()
                    .tag(tabs[1])
                GroceryCartView()
                    .tag(tabs[2])
                OrderHistoryView()
                    .tag(tabs[3])
                AccountView()
                    .tag(tabs[4])
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .environment(\.isTabBarHidden, $isTabBarHidden)
            
            if !isTabBarHidden {
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
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

extension EnvironmentValues {
    var isTabBarHidden: Binding<Bool> {
        get { self[TabBarHiddenKey.self] }
        set { self[TabBarHiddenKey.self] = newValue }
    }
}

private struct TabBarHiddenKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

struct TabButon: View {
    var image : String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: { selectedTab = image }) {
            Image(image)
                .renderingMode(.template)
                .foregroundStyle(selectedTab == image ? AppColors.appleGreen : Color.black.opacity(0.4))
                .padding()
        }
    }
}


#Preview {
    CustomTabView()
}
