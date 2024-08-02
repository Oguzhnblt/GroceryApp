//
//  OnboardingView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var showSignupView: Bool = false
    @State private var isLoggedIn: Bool = false
    
    @StateObject private var authManager = GroceryAuthManager()
    @Environment(\.dismiss) private var dismiss
    
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
                            .foregroundColor(Color(red: 0.01, green: 0.01, blue: 0.01))
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
            .fullScreenCover(isPresented: $isLoggedIn) {
                CustomTabView()
                    .environmentObject(GroceryDataManager())
            }
            .onChange(of: authManager.isAuthenticated) { _, newValue in
                if newValue {
                    isLoggedIn = true
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Login")
                .font(Font.custom("Gilroy-SemiBold", size: 26))
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            
            Text("Enter your email and password")
                .font(Font.custom("Gilroy-Medium", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
        }
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Email")
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            TextField("Enter your email", text: $authManager.email)
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
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
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            SecureField("Password", text: $authManager.password)
                .font(Font.custom("Gilroy-Medium", size: 18))
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
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
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                authManager.login {
                    self.isLoggedIn = true
                }
            }) {
                GroceryButton(text: "Log In")
            }
            
            HStack {
                Text("Don’t have an account?")
                    .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                
                Button(action: {
                    self.showSignupView = true
                }) {
                    Text("Signup")
                        .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                        .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
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
            .cornerRadius(8)
    }
}

#Preview {
    LoginView()
        .environmentObject(GroceryAuthManager())
}
