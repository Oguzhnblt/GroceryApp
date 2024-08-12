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
                        .font(AppFonts.gilroySemiBold(size: 24))
                    Text(message)
                        .font(AppFonts.gilroyMedium(size: 16))
                        .foregroundColor(Color.gray)
                }
                .multilineTextAlignment(.center)
            }
            .padding([.leading, .trailing], 50)
        }
}

#Preview {
    EmptyCardView(title: "", message: "")
}
