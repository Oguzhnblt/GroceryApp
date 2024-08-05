//
//  OnboardingView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var showSignupView: Bool = false
    @EnvironmentObject private var authManager: GroceryAuthManager
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Image("blur").ignoresSafeArea(.all))
                        .opacity(0.06)
                        .frame(height: 200)
                    
                    VStack {
                        Image("login_icon")
                        
                        Text("Get your groceries\nwith nectar")
                            .font(Font.custom("Gilroy-Medium", size: 16))
                            .foregroundColor(AppColors.almostBlack)
                            .padding(.bottom, 15)
                        
                        if let errorMessage = authManager.errorMessage {
                            errorMessageView(message: errorMessage)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 30) {
                    headerSection
                    
                    emailSection
                    
                    passwordSection
                    
                    forgotPasswordButton
                    
                    actionButtons
                }
                .padding([.leading, .trailing], 25)
            }
            .onAppear {
                if authManager.isAuthenticated {
                    // Navigate to the main view if already authenticated
                    authManager.isAuthenticated = true
                }
            }
            .fullScreenCover(isPresented: Binding<Bool>(
                get: { authManager.isAuthenticated },
                set: { newValue in
                    if !newValue {
                        authManager.isAuthenticated = false
                    }
                }
            )) {
                CustomTabView()
                    .environmentObject(authManager)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Login")
                .font(Font.custom("Gilroy-SemiBold", size: 26))
                .foregroundColor(AppColors.darkGreen)
            
            Text("Enter your email and password")
                .font(Font.custom("Gilroy-Medium", size: 16))
                .foregroundColor(AppColors.oliveGreen)
        }
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Email")
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(AppColors.oliveGreen)
            
            TextField("Enter your email", text: $authManager.email)
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(AppColors.oliveGreen)
                .onChange(of: authManager.email) {
                    authManager.errorMessage = nil
                }
            
            Divider()
        }
    }
    
    private var passwordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Password")
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Password", text: $authManager.password)
                .font(Font.custom("Gilroy-Medium", size: 18))
                .foregroundColor(AppColors.darkGreen)
                .onChange(of: authManager.password) {
                    authManager.errorMessage = nil
                }
            
            Divider()
        }
    }
    
    private var forgotPasswordButton: some View {
        HStack {
            Spacer()
            Button(action: {
                // Forgot password action
            }) {
                Text("Forgot Password?")
                    .font(Font.custom("Gilroy-Medium", size: 14))
                    .foregroundColor(AppColors.darkGreen)
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                authManager.login { result in
                    switch result {
                    case .success:
                        if !authManager.isEmailVerified {
                            authManager.sendVerificationEmail { result in
                                switch result {
                                case .success:
                                    authManager.errorMessage = "Please verify your email before logging in."
                                case .failure(let error):
                                    authManager.errorMessage = error.localizedDescription
                                }
                            }
                        } else {
                            authManager.isAuthenticated = true
                        }
                    case .failure(let error):
                        authManager.errorMessage = error.localizedDescription
                    }
                }
            }) {
                GroceryButton(text: "Log In")
            }
            
            HStack {
                Text("Don’t have an account?")
                    .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                    .foregroundColor(AppColors.darkGreen)
                
                Button(action: {
                    self.showSignupView = true
                }) {
                    Text("Signup")
                        .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                        .foregroundColor(AppColors.appleGreen)
                }
                .sheet(isPresented: $showSignupView) {
                    SignupView()
                        .environmentObject(authManager)
                }
                
            }
        }
    }
    
    private func errorMessageView(message: String) -> some View {
        Text(message)
            .font(Font.custom("Gilroy-Medium", size: 14))
            .foregroundColor(.red)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}

#Preview {
    LoginView()
        .environmentObject(GroceryAuthManager())
}

