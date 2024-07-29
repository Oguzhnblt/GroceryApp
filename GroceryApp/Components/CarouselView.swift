//
//  CarouselView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI


struct CarouselView: View {
    let banners = ["freshveg", "freshveg2", "freshveg3"]
    
    var body: some View {
        TabView {
            ForEach(banners, id: \.self) { banner in
                Image(banner)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .frame(height: 150)
        .tabViewStyle(PageTabViewStyle())
        .padding()
    }
}

#Preview {
    CarouselView()
}
