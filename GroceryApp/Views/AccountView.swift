//
//  AccountView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 5.08.2024.
//


import SwiftUI

struct AccountView: View {
    @EnvironmentObject private var authManager: GroceryAuthManager
    @EnvironmentObject private var dataManager: GroceryDataManager
    @State private var showLoginView = false
    @State private var showAddCreditCardView = false
    @State private var showDeliveryAddressView = false
    @State private var showAccountInfoView = false
    @State private var showAboutView = false
    @State private var selectedAddress: DeliveryAddress? = nil
    @State private var selectedCard: CreditCard? = nil
    @State private var showLogoutConfirmation = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 25) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Image("blur").ignoresSafeArea(.all))
                        .opacity(0.06)
                        .frame(height: 100)
                    
                    VStack {
                        Image("login_icon")
                        
                        Text("Get your groceries\nwith nectar")
                            .font(AppFonts.gilroyMedium(size: 18))
                            .foregroundColor(AppColors.almostBlack)
                            .padding(.bottom, 15)
                    }
                    .offset(x: 0, y: -100)
                    
                    Divider()
                    
                    HStack {
                        Button(action: {
                            showAccountInfoView.toggle()
                        }) {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundStyle(.black).bold()
                                Text("Account Info")
                                    .font(AppFonts.gilroySemiBold(size: 14))
                                    .foregroundColor(AppColors.darkGreen)
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    
                    HStack {
                        Button(action: {
                            showDeliveryAddressView.toggle()
                        }) {
                            HStack {
                                Image("delivery_address")
                                Text("Delivery Address")
                                    .font(AppFonts.gilroySemiBold(size: 14))
                                    .foregroundColor(AppColors.darkGreen)
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    
                    HStack {
                        Button(action: {
                            showAddCreditCardView.toggle()
                        }) {
                            HStack {
                                Image("payment")
                                Text("Credit Card Info")
                                    .font(AppFonts.gilroySemiBold(size: 14))
                                    .foregroundColor(AppColors.darkGreen)
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    
                    HStack {
                        Button(action: {
                            showAboutView.toggle()
                        }) {
                            HStack {
                                Image("about")
                                Text("About")
                                    .font(AppFonts.gilroySemiBold(size: 14))
                                    .foregroundColor(AppColors.darkGreen)
                                    .lineLimit(1)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    Divider()
                    
                    Button {
                        showLogoutConfirmation = true
                    } label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 350, height: 60)
                                .background(AppColors.backgroundGray)
                                .cornerRadius(19)
                            HStack(spacing: 100) {
                                Image("logout")
                                Text("Log Out")
                                    .font(AppFonts.gilroySemiBold(size: 18))
                                    .foregroundColor(AppColors.appleGreen)
                                    .padding(.trailing, 100)
                            }
                        }
                        .frame(width: 350, height: 60)
                    }
                    .alert(isPresented: $showLogoutConfirmation) {
                        Alert(
                            title: Text("Log Out"),
                            message: Text("Are you sure you want to logout?"),
                            primaryButton: .destructive(Text("Log Out")) {
                                authManager.logout { _ in
                                    showLoginView = true
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding([.leading, .trailing], 25)
            .fullScreenCover(isPresented: $showLoginView) {
                LoginView()
                    .environmentObject(authManager)
            }
            .sheet(isPresented: $showDeliveryAddressView) {
                DeliveryAddressView(selectedAddress: $selectedAddress)
                    .environmentObject(dataManager)
            }
            .sheet(isPresented: $showAddCreditCardView) {
                PaymentCardView(selectedCard: $selectedCard)
                    .environmentObject(dataManager)
            }
            .sheet(isPresented: $showAboutView) {
                AboutView()
            }
            .sheet(isPresented: $showAccountInfoView) {
                AccountInfoView()
                    .environmentObject(authManager)
            }
        }
    }
}

#Preview {
    AccountView()
}
