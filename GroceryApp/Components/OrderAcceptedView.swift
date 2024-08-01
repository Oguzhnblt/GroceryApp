//
//  OrderAcceptedView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 31.07.2024.
//

import SwiftUI

struct OrderAcceptedView: View {
    var body: some View {
        ZStack() {
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 413.83, height: 896)
                    .background(Color(red: 0.77, green: 0.77, blue: 0.77))
                    .offset(x: 0, y: 0)
                ZStack() {
                    ZStack() {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 273.76, height: 649.93)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/274x650"))
                            )
                            .offset(x: -146.37, y: 321.77)
                            .rotationEffect(.degrees(98.76))
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 273.76, height: 649.93)
                            .background(
                                AsyncImage(url: URL(string: "https://via.placeholder.com/274x650"))
                            )
                            .offset(x: -104.66, y: 592.33)
                            .rotationEffect(.degrees(98.76))
                    }
                    .frame(width: 649.93, height: 547.51)
                    .offset(x: -37.92, y: -85.78)
                    .rotationEffect(.degrees(8.76))
                    .opacity(0.80)
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 414.60, height: 510.09)
                        .background(Color(red: 0.99, green: 0.99, blue: 0.99).opacity(0.60))
                        .offset(x: -83.87, y: 203.53)
                }
                .frame(width: 725.77, height: 917.14)
                .offset(x: 84.08, y: -396.48)
                ZStack() {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 244.57, height: 414.11)
                        .background(
                            AsyncImage(url: URL(string: "https://via.placeholder.com/245x414"))
                        )
                        .offset(x: 329.28, y: 191.64)
                        .rotationEffect(.degrees(-90))
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 413.83, height: 457.85)
                        .background(Color(red: 1, green: 1, blue: 1).opacity(0.55))
                        .offset(x: -0.09, y: -0.23)
                }
                .frame(width: 414, height: 458.30)
                .offset(x: 0.09, y: 219.15)
            }
            .frame(width: 413.83, height: 896)
            .offset(x: -0, y: 0)
            ZStack() {
                Group {
                    ZStack() {
                        Ellipse()
                            .foregroundColor(.clear)
                            .frame(width: 158.15, height: 158.15)
                            .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                            .offset(x: 0, y: 0)
                        Ellipse()
                            .foregroundColor(.clear)
                            .frame(width: 138.28, height: 138.28)
                            .overlay(
                                Ellipse()
                                    .inset(by: 1)
                                    .stroke(Color(red: 1, green: 1, blue: 1).opacity(0.70), lineWidth: 1)
                            )
                            .offset(x: -0, y: -0)
                            .shadow(
                                color: Color(red: 0, green: 0, blue: 0, opacity: 0.12), radius: 4, y: 3
                            )
                    }
                    .frame(width: 158.15, height: 158.15)
                    .offset(x: 22.78, y: -3.32)
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 15.16, height: 15.16)
                        .background(Color(red: 0.39, green: 0.48, blue: 1))
                        .offset(x: 45.23, y: 112.57)
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 15.16, height: 15.16)
                        .overlay(
                            Ellipse()
                                .inset(by: 0.50)
                                .stroke(Color(red: 0.75, green: 0.37, blue: 0.99), lineWidth: 0.50)
                        )
                        .offset(x: 116.89, y: -7.45)
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 16.60, height: 16.60)
                        .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                        .offset(x: -3.43, y: -111.85)
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 8.77, height: 8.77)
                        .background(Color(red: 0.95, green: 0.38, blue: 0.25))
                        .offset(x: 20.13, y: -97.84)
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 15.36, height: 15.36)
                        .overlay(
                            Ellipse()
                                .inset(by: 0.50)
                                .stroke(Color(red: 0.97, green: 0.70, blue: 0.23), lineWidth: 0.50)
                        )
                        .offset(x: -76.48, y: -33.47)
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 16.89, height: 16.89)
                        .overlay(
                            Ellipse()
                                .inset(by: 0.50)
                                .stroke(Color(red: 0.33, green: 0.69, blue: 0.46), lineWidth: 0.50)
                        )
                        .offset(x: -58.84, y: 87.66)
                }
                Group {
                    Ellipse()
                        .foregroundColor(.clear)
                        .frame(width: 8.07, height: 8.07)
                        .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                        .offset(x: 29.73, y: 103.88)
                        .rotationEffect(.degrees(-180))
                }
            }
            .frame(width: 269.08, height: 240.31)
            .offset(x: -14, y: -176.15)
            Text("Your Order has been\n accepted")
                .font(Font.custom("Gilroy", size: 28).weight(.semibold))
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                .offset(x: 0, y: 44.67)
            Text("Your items has been placcd and is on \nit’s way to being processed")
                .font(Font.custom("Gilroy-Medium", size: 16))
                .lineSpacing(21)
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                .offset(x: 0, y: 119.67)
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 364, height: 67)
                    .cornerRadius(19)
                    .offset(x: 0, y: 0)
                Text("Back to home")
                    .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                    .lineSpacing(18)
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                    .offset(x: 0.46, y: 0)
            }
            .frame(width: 364, height: 67)
            .offset(x: 0.01, y: 376)
            ZStack() {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 364, height: 67)
                    .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                    .cornerRadius(19)
                    .offset(x: 0, y: 0)
                Text("Track Order")
                    .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                    .lineSpacing(18)
                    .foregroundColor(Color(red: 1, green: 0.98, blue: 1))
                    .offset(x: -0.04, y: 0)
            }
            .frame(width: 364, height: 67)
            .offset(x: 0.01, y: 309)
        }
        .frame(width: 414, height: 896)
        .background(.white)
    }
}

#Preview {
    OrderAcceptedView()
}
