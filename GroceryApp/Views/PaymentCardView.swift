//
//  PaymentCardView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//
import SwiftUI

struct PaymentCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedCard: String?
    @Binding var cards: [String]
    
    @State private var cardNumber: String = ""
    @State private var cardholderName: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var isAddingNewCard: Bool = false
    
    private func formatCardNumber(_ number: String) -> String {
        let digits = number.filter { $0.isNumber }
        let formatted = digits.chunked(into: 4).joined(separator: " ")
        return formatted
    }
    
    private func formatExpirationDate(_ date: String) -> String {
        let digits = date.filter { $0.isNumber }
        let formatted = digits.chunked(into: 2).joined(separator: "/")
        return formatted
    }
    
    private func formatInput(_ input: String, maxLength: Int) -> String {
        return String(input.prefix(maxLength))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text("Card Information")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
            }
            .padding(.top)
            
            Divider()
            
            // Card List or Warning
            if cards.isEmpty {
                VStack {
                    Image(systemName: "creditcard.trianglebadge.exclamationmark")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                    Text("No cards available")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(cards.indices, id: \.self) { index in
                            HStack {
                                if selectedCard == cards[index] {
                                    HStack {
                                        Text(cards[index])
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                            .padding(.vertical, 12)
                                            .padding(.leading, 8)
                                        Spacer()
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                                            .padding(.trailing)
                                    }
                                    .background(Color(red: 0.33, green: 0.69, blue: 0.46).opacity(0.2))
                                    .cornerRadius(8)
                                }
                                else {
                                    HStack {
                                        Text(cards[index])
                                            .font(.system(size: 16))
                                            .foregroundColor(.primary)
                                            .padding(.vertical, 12)
                                            .padding(.leading, 8)
                                        Spacer()
                                        Circle()
                                            .stroke(Color.gray, lineWidth: 1)
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing, 18)
                                    }
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    
                                }
                                Button(action: {
                                    // Remove the card safely
                                    if cards.indices.contains(index) {
                                        let cardToRemove = cards[index]
                                        cards.remove(at: index)
                                        if selectedCard == cardToRemove {
                                            selectedCard = nil
                                        }
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.black)
                                        .padding(.trailing)
                                }
                            }
                            .onTapGesture {
                                selectedCard = cards[index]
                            }
                        }
                    }
                }
            }
            
            Divider()
            
            // New Card Section
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Button(action: {
                        isAddingNewCard.toggle()
                    }) {
                        Text(isAddingNewCard ? "Cancel" : "Add New Card")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color.white)
                    
                    if isAddingNewCard {
                        Button(action: {
                            if !cardNumber.isEmpty && !cardholderName.isEmpty && !expirationDate.isEmpty && !cvv.isEmpty {
                                // Handle adding new card logic here
                                let formattedCardNumber = formatCardNumber(cardNumber)
                                let newCard = "**** **** **** \(formattedCardNumber.suffix(4))"
                                cards.append(newCard)
                                selectedCard = newCard
                                cardNumber = ""
                                cardholderName = ""
                                expirationDate = ""
                                cvv = ""
                                isAddingNewCard = false
                            }
                        }) {
                            Text("Save Card")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 0.33, green: 0.69, blue: 0.46))
                                .cornerRadius(8)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
                
                if isAddingNewCard {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Card number", text: $cardNumber)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                            .onChange(of: cardNumber) { _,newValue in
                                cardNumber = formatInput(newValue, maxLength: 19)
                                cardNumber = formatCardNumber(cardNumber)
                            }
                        
                        TextField("Cardholder name", text: $cardholderName)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        HStack(spacing: 8) {
                            TextField("MM/YY", text: $expirationDate)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .frame(width: 150)
                                .keyboardType(.numberPad)
                                .onChange(of: expirationDate) { _,newValue in
                                    expirationDate = formatInput(newValue, maxLength: 5)
                                    expirationDate = formatExpirationDate(expirationDate)
                                }
                            
                            Spacer()
                            
                            TextField("CVV", text: $cvv)
                                .padding(10)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .frame(width: 150)
                                .keyboardType(.numberPad)
                                .onChange(of: cvv) { _,newValue in
                                    cvv = formatInput(newValue, maxLength: 3)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
}

extension String {
    func chunked(into size: Int) -> [String] {
        guard size > 0 else { return [] }
        return stride(from: 0, to: count, by: size).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: size, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
}


struct PaymentCardView_Previews: PreviewProvider {
    @State static var selectedCard: String? = nil
    @State static var cards: [String] = ["1234 1234 1234 1234", "5678 5678 5678 5678"]
    
    static var previews: some View {
        PaymentCardView(selectedCard: $selectedCard, cards: $cards)
            .previewLayout(.sizeThatFits)
    }
}
