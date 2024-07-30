//
//  EmptyCardView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 31.07.2024.
//

import SwiftUI

struct EmptyCardView: View {
    var title: String
    var message: String

    var body: some View {
            VStack(alignment: .center, spacing: 20) {
                Image("empty_cart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                
                VStack(alignment: .center, spacing: 20) {
                    Text(title)
                        .font(.custom("Gilroy-SemiBold", size: 24))
                    Text(message)
                        .font(.custom("Gilroy-Medium", size: 16))
                        .foregroundColor(Color.gray)
                }
                .multilineTextAlignment(.center)
            }
            .padding(.top, 50)
            .padding([.leading, .trailing], 50)
        }
}

#Preview {
    EmptyCardView(title: "", message: "")
}
