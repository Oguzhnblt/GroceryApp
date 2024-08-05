//
//  OrderAcceptedView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 4.08.2024.
//

import SwiftUI

struct OrderAcceptedView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.clear)
                .background(Image("blur").ignoresSafeArea(.all))
                .opacity(0.07)
                .frame(height: 200)
            
            VStack(alignment: .center, spacing: 100) {
                Image("order_accept")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .padding(.trailing, 20)
                    .padding(.top, 40)
                
                VStack(spacing: 40) {
                    Text("Your Order has been\n accepted")
                        .font(Font.custom("Gilroy-SemiBold", size: 28))
                        .foregroundColor(AppColors.darkGreen)
                        .multilineTextAlignment(.center)
                    
                    Text("Your items has been placed and is on \nit’s way to being processed")
                        .font(Font.custom("Gilroy-Medium", size: 16))
                        .lineSpacing(10)
                        .multilineTextAlignment(.center)
                        .foregroundColor(AppColors.oliveGreen)
                    
                    Text("Check your order history!")
                        .font(Font.custom("Gilroy-Medium", size: 16))
                        .lineSpacing(10)
                        .multilineTextAlignment(.center)
                        .foregroundColor(AppColors.oliveGreen)
                }
            }
        }
    }
}

#Preview {
    OrderAcceptedView()
}
