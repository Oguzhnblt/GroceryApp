//
//  SignupView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import SwiftUI

struct SignupView: View {
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
                        .font(AppFonts.gilroyMedium(size: 16))
                        .foregroundColor(AppColors.almostBlack)
                        .padding(.bottom, 15)
                    
                    if let errorMessage = authManager.errorMessage {
                        errorMessageView(message: errorMessage)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 20) {
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
    
    // Genel stil oluşturma
    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .font(AppFonts.gilroySemiBold(size: 16))
            .foregroundColor(AppColors.oliveGreen)
    }
    
    private func textField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .font(AppFonts.gilroySemiBold(size: 16))
            .foregroundColor(AppColors.oliveGreen)
            .onChange(of: text.wrappedValue) {
                authManager.errorMessage = nil
            }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Signup")
                .font(AppFonts.gilroySemiBold(size: 26))
                .foregroundColor(AppColors.darkGreen)
            
            Text("Enter your credentials to continue")
                .font(AppFonts.gilroyMedium(size: 16))
                .foregroundColor(AppColors.oliveGreen)
        }
    }
    
    private var usernameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Username")
            textField("Enter your username", text: $username)
            Divider()
        }
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Email")
            textField("Enter your email", text: $authManager.email)
            Divider()
        }
    }
    
    private var passwordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Password")
            SecureField("Password", text: $authManager.password)
                .font(AppFonts.gilroyMedium(size: 18))
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
                    .font(AppFonts.gilroyMedium(size: 14))
                    .foregroundColor(AppColors.oliveGreen)
                
                Text("Terms & Conditions")
                    .font(AppFonts.gilroyMedium(size: 14))
                    .foregroundColor(AppColors.darkGreen)
            }
        }
    }
    
    private var actionButtons: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                authManager.signUp { _ in
                    if authManager.isAuthenticated {
                        alertMessage = authManager.successMessage ?? "Success"
                        showAlert = true
                    } else if let error = authManager.errorMessage {
                        alertMessage = error
                        showAlert = true
                    }
                }
            }) {
                GroceryButton(text: "Sign Up")
            }
            
            HStack {
                Text("Already have an account?")
                    .font(AppFonts.gilroySemiBold(size: 14))
                    .foregroundColor(AppColors.darkGreen)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Log In")
                        .font(AppFonts.gilroySemiBold(size: 14))
                        .foregroundColor(AppColors.appleGreen)
                }
            }
        }
    }
    
    private func errorMessageView(message: String) -> some View {
        Text(message)
            .font(AppFonts.gilroyMedium(size: 14))
            .foregroundColor(.red)
            .padding()
            .cornerRadius(8)
    }
}

#Preview {
    SignupView()
}
