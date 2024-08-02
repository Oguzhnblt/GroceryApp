//
//  SplashView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(red: 0.33, green: 0.69, blue: 0.46)
                .ignoresSafeArea(.all)
            HStack {
                Image("splash_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 55, height: 64)
                VStack {
                    Image("nectar")
                        .font(.custom("Gilroy-Medium", size: 65))
                        .foregroundColor(.white)
                    Text("online groceriet")
                        .font(Font.custom("Gilroy-Medium", size: 14))
                        .tracking(5.50)
                        .lineSpacing(18)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
