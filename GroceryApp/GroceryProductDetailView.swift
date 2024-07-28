//
//  GroceryProductDetailView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI

struct GroceryProductDetailView: View {
    @State private var quantity = 1
    private var pricePerUnit: Double = 4.99  // Mock data düzeltilecek

    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // Üst görsel
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 413.60, height: 371.44)
                    .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                    .cornerRadius(25)
                    .overlay(
                        Image("banana")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 413.60, height: 371.44)
                            .cornerRadius(25)
                    )
                
                // Ürün
                VStack(alignment: .leading, spacing: 25) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Organic Bananas")
                            .font(Font.custom("Gilroy-Bold", size: 24))
                            .tracking(0.10)
                            .lineSpacing(18)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                        
                        Text("1kg, Price")
                            .font(Font.custom("Gilroy", size: 16).weight(.semibold))
                            .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                    }
                    
                    // Miktar ve Fiyat
                    HStack {
                        // Miktar butonları
                        HStack(spacing: 20) {
                            Button(action: { if quantity > 1 { quantity -= 1 } }) {
                                Image(systemName: "minus")
                                    .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                                    .frame(width: 17, height: 17)
                            }
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 45, height: 45)
                                .cornerRadius(17)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 17)
                                        .inset(by: 0.50)
                                        .stroke(Color(red: 0.89, green: 0.89, blue: 0.89), lineWidth: 0.50)
                                )
                                .overlay(
                                    Text("\(quantity)")
                                        .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                                        .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                                )
                            
                            Button(action: { quantity += 1 }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                                    .frame(width: 17, height: 17)
                            }
                        }
                        
                        Spacer()
                        
                        // Fiyat
                        Text("$\(String(format: "%.2f", pricePerUnit * Double(quantity)))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                    }
                }
                .padding([.leading, .trailing, .top], 25)
                
                // Ürün detayları ve besin değerleri
                VStack(spacing: 20) {
                    Divider()
                    
                    DisclosureGroup {
                        Text("Apples Are Nutritious. Apples May Be Good For Weight Loss. Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet.")
                            .padding(.top, 5)
                            .font(.body)
                    } label: {
                        Text("Product Detail")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                    }
                    
                    Divider()
                    
                    DisclosureGroup {
                        VStack(alignment: .leading, spacing: 5) {
                            NutritionRow(label: "Calories:", value: "52 kcal")
                            NutritionRow(label: "Carbohydrates:", value: "14 g")
                            NutritionRow(label: "Protein:", value: "0.3 g")
                            NutritionRow(label: "Fat:", value: "0.2 g")
                            NutritionRow(label: "Fiber:", value: "2.4 g")
                            NutritionRow(label: "Sugar:", value: "10 g")
                        }
                        .padding(.top, 5)
                        .padding()
                        .font(.body)
                    } label: {
                        HStack {
                            Text("Nutritions")
                                .font(.headline)
                                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                            Spacer()
                            Text("100gr")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                                .padding(5)
                                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                .cornerRadius(5)
                        }
                    }
                }
                .padding(25)
                
                // Sepete ekle butonu
                Button(action: {
                    // Sepete ekleme işlemi
                }) {
                    Text("Add To Cart")
                        .foregroundColor(.white)
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding([.leading, .trailing], 25)
                .padding(.bottom, 35)
            }
            .padding([.leading, .trailing])
        }
    }
}

struct NutritionRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
        Divider()
    }
}

#Preview {
    GroceryProductDetailView()
        .ignoresSafeArea()
}
