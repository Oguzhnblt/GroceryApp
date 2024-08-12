//
//  AboutView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 5.08.2024.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("About This App")
                    .font(AppFonts.gilroySemiBold(size: 18))
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .font(AppFonts.gilroySemiBold(size: 16))
                        .foregroundColor(AppColors.appleGreen)
                }
            }
            .padding(.top)
            
            Divider()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Welcome to Our Grocery App!")
                        .font(AppFonts.gilroySemiBold(size: 20))
                        .foregroundColor(.primary)
                    
                    Text("Our app is designed to make your grocery shopping experience seamless and enjoyable. With a user-friendly interface and a range of features, you can easily browse through products, manage your cart, and checkout with just a few taps.")
                        .font(AppFonts.gilroyMedium(size: 16))
                        .foregroundColor(.secondary)
                    
                    Text("Features include:")
                        .font(AppFonts.gilroySemiBold(size: 16))
                        .foregroundColor(.primary)
                    
                    Text("• Browse and search for products\n• Add items to your cart and manage quantities\n• Save and manage delivery addresses\n• Add and manage credit card information\n• View order history\n• And much more!")
                        .font(AppFonts.gilroyMedium(size: 16))
                        .foregroundColor(.secondary)
                    
                    Text("Thank you for using our app! If you have any feedback or need assistance, feel free to contact our support team.")
                        .font(AppFonts.gilroyMedium(size: 16))
                        .foregroundColor(.secondary)
                    
                    Text("Version 1.0.0")
                        .font(AppFonts.gilroyMedium(size: 14))
                        .foregroundStyle(AppColors.oliveGreen)
                }
                .padding()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    AboutView()
}
