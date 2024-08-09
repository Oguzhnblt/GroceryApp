//
//  CategoryCell.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct CategoryCell: View {
    var imageName: String
    var title: String
    var backgroundColor: Color
    var borderColor: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 174.50, height: 189.11)
                .background(backgroundColor.opacity(0.10))
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .inset(by: 0.50)
                        .stroke(borderColor.opacity(0.70), lineWidth: 0.50)
                )
                .shadow(
                    color: Color(red: 0, green: 0, blue: 0, opacity: 0), radius: 12, y: 6
                )
            
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 95, height: 95)
                
                Text(title)
                    .font(AppFonts.gilroyBold(size: 16))
                    .tracking(0.10)
                    .lineSpacing(22)
                    .foregroundColor(AppColors.darkGreen)
            }
        }
    }
}

#Preview {
    CategoryCell(imageName: "vegfruit", title: "Fresh Fruits\n& Vegetables", backgroundColor: AppColors.appleGreen, borderColor: AppColors.appleGreen)
}
