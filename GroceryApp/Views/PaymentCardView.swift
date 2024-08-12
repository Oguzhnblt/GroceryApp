//
//  PaymentCardView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 1.08.2024.
//

import SwiftUI

struct PaymentCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataManager: GroceryDataManager
    
    @Binding var selectedCard: CreditCard?
    
    @State private var cardNumber: String = ""
    @State private var cardholderName: String = ""
    @State private var expirationDate: String = ""
    @State private var cvv: String = ""
    @State private var isAddingNewCard: Bool = false
    @State private var isEditingCard: Bool = false
    @State private var editingCardId: String? = nil
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    private func loadCardDetails(for card: CreditCard) {
        cardNumber = card.cardNumber
        cardholderName = card.cardholderName
        expirationDate = card.expirationDate
        cvv = card.cvv
    }
    
    private func handleCardAction() {
        guard !cardNumber.isEmpty, !cardholderName.isEmpty, !expirationDate.isEmpty, !cvv.isEmpty else {
            alertMessage = "All fields are required."
            showAlert = true
            return
        }
        
        let digitsOnlyCardNumber = cardNumber.digitsOnly
        guard digitsOnlyCardNumber.count == 16 else {
            alertMessage = "Card number must be 16 digits."
            showAlert = true
            return
        }
        
        guard expirationDate.count == 5, cvv.count == 3 else {
            alertMessage = "Invalid expiration date or CVV."
            showAlert = true
            return
        }
        
        if isEditingCard, let editingCardId = editingCardId {
            dataManager.updateCard(cardId: editingCardId, cardNumber: cardNumber, cardholderName: cardholderName, expirationDate: expirationDate, cvv: cvv)
        } else {
            dataManager.addCard(cardNumber: cardNumber, cardholderName: cardholderName, expirationDate: expirationDate, cvv: cvv)
        }
        
        resetForm()
    }
    
    private func resetForm() {
        cardNumber = ""
        cardholderName = ""
        expirationDate = ""
        cvv = ""
        isAddingNewCard = false
        isEditingCard = false
        editingCardId = nil
    }
    
    var body: some View {
        VStack(spacing: 16) {
            headerView
            Divider()
            cardListView
            Divider()
            newEditCardSection
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .onAppear {
            dataManager.fetchUserCards()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Missing Information"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Card Information")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            Spacer()
            Button("Done") {
                presentationMode.wrappedValue.dismiss()
            }
            .font(AppFonts.gilroySemiBold(size: 16))
            .foregroundColor(AppColors.appleGreen)
        }
        .padding(.top)
    }
    
    private var cardListView: some View {
        Group {
            if dataManager.userCards.isEmpty {
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
                List {
                    ForEach(dataManager.userCards) { card in
                        HStack {
                            Image("card")
                            Text(card.cardNumber)
                                .font(.system(size: 16))
                                .foregroundColor(.primary)
                                .padding(.vertical, 12)
                                .padding(.leading, 8)
                            Spacer()
                            if selectedCard?.id == card.id {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(AppColors.appleGreen)
                                    .padding(.trailing)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCard = card
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                dataManager.removeCard(cardId: card.id!)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            Button {
                                isEditingCard = true
                                isAddingNewCard = true
                                editingCardId = card.id
                                loadCardDetails(for: card)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(AppColors.appleGreen)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
    
    private var newEditCardSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Button(action: {
                    if isEditingCard {
                        resetForm()
                    } else {
                        isAddingNewCard.toggle()
                    }
                }) {
                    Text(isAddingNewCard ? "Cancel" : "Add New Card")
                        .font(AppFonts.gilroySemiBold(size: 16))
                        .foregroundColor(AppColors.appleGreen)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color.white)
                
                if isAddingNewCard {
                    Button(action: handleCardAction) {
                        Text(isEditingCard ? "Save Changes" : "Save Card")
                            .font(AppFonts.gilroySemiBold(size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(AppColors.appleGreen)
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
                            cardNumber = newValue
                                .limited(to: 19)
                                .formattedCardNumber()
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
                                expirationDate = newValue
                                    .limited(to: 5)
                                    .formattedExpirationDate()
                            }
                        
                        Spacer()
                        
                        TextField("CVV", text: $cvv)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(width: 150)
                            .keyboardType(.numberPad)
                            .onChange(of: cvv) { _,newValue in
                                cvv = newValue
                                    .limited(to: 3)
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct PaymentCardView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCardView(selectedCard: .constant(nil))
            .environmentObject(GroceryDataManager())
    }
}
