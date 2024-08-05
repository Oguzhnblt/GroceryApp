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
    @State private var isLogoutInProgress = false
    @State private var showLoginView = false
    @State private var showAddCreditCardView = false
    @State private var showDeliveryAddressView = false
    @State private var showAccountInfoView = false
    @State private var showAboutView = false
    @State private var selectedAddress: DeliveryAddress? = nil
    @State private var selectedCard: CreditCard? = nil
    
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
                            .font(Font.custom("Gilroy-Medium", size: 18))
                            .foregroundColor(AppColors.almostBlack)
                            .padding(.bottom, 15)
                    }
                    .offset(x: 0, y: -100)
                    
                    Divider()
                    
                    HStack {
                        Button(action: {
                            // Show Account Info View
                            showAccountInfoView.toggle()
                        }) {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundStyle(.black).bold()
                                Text("Account Info")
                                    .font(.system(size: 14, weight: .semibold))
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
                                    .font(.system(size: 14, weight: .semibold))
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
                                    .font(.system(size: 14, weight: .semibold))
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
                                    .font(.system(size: 14, weight: .semibold))
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
                        isLogoutInProgress = true
                        withAnimation {
                            authManager.logout {_ in 
                                isLogoutInProgress = false
                                showLoginView = true
                            }
                        }
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
                                    .font(Font.custom("Gilroy", size: 18).weight(.semibold))
                                    .foregroundColor(AppColors.appleGreen)
                                    .padding(.trailing, 100)
                            }
                        }
                        .frame(width: 350, height: 60)
                    }
                    .disabled(isLogoutInProgress)
                    .opacity(isLogoutInProgress ? 0.6 : 1.0)
                    .overlay(
                        Group {
                            if isLogoutInProgress {
                                ZStack {
                                    Color.black.opacity(0.4)
                                        .edgesIgnoringSafeArea(.all)
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(1.5)
                                }
                                .transition(.opacity)
                            }
                        }
                    )
                }
                .opacity(isLogoutInProgress ? 0.5 : 1.0)
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
