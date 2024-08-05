//
//  SignupView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import SwiftUI

struct SignupView: View {
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var authManager = GroceryAuthManager()
    
    var body: some View {
        NavigationStack {
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
                
                usernameSection
                
                emailSection
                
                passwordSection
                
                termsSection
                
                actionButtons
            }
            .padding([.leading, .trailing], 25)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Signup")
                .font(Font.custom("Gilroy-SemiBold", size: 26))
                .foregroundColor(AppColors.darkGreen)
            
            Text("Enter your credentials to continue")
                .font(Font.custom("Gilroy-Medium", size: 16))
                .foregroundColor(AppColors.oliveGreen)
        }
    }
    
    private var usernameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Username")
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(AppColors.oliveGreen)
            
            TextField("Enter your username", text: $username)
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(AppColors.oliveGreen)
            
            Divider()
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
    
    private var termsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("By signing up, you agree to our")
                    .font(Font.custom("Gilroy-Medium", size: 14))
                    .foregroundColor(AppColors.oliveGreen)
                
                Text("Terms & Conditions")
                    .font(Font.custom("Gilroy-Medium", size: 14))
                    .foregroundColor(AppColors.darkGreen)
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                authManager.signUp {_ in 
                    if authManager.isAuthenticated {
                        alertMessage = authManager.successMessage!
                        showAlert = true
                    } else if let error = authManager.errorMessage {
                        alertMessage = error
                        showAlert = true
                    }}
            }) {
                GroceryButton(text: "Sign Up")
            }
            
            HStack {
                Text("Already have an account?")
                    .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                    .foregroundColor(AppColors.darkGreen)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Log In")
                        .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                        .foregroundColor(AppColors.appleGreen)
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
    SignupView()
}
