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
                        .foregroundColor(Color(red: 0.01, green: 0.01, blue: 0.01))
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
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            
            Text("Enter your credentials to continue")
                .font(Font.custom("Gilroy-Medium", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
        }
    }
    
    private var usernameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Username")
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            TextField("Enter your username", text: $username)
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            Divider()
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
    
    private var termsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("By signing up, you agree to our")
                    .font(Font.custom("Gilroy-Medium", size: 14))
                    .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
                
                Text("Terms & Conditions")
                    .font(Font.custom("Gilroy-Medium", size: 14))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                authManager.signUp {
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
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Log In")
                        .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                        .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
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
