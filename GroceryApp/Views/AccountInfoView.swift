//
//  AccountInfoView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 5.08.2024.
//

import SwiftUI

struct AccountInfoView: View {
    @EnvironmentObject private var authManager: GroceryAuthManager
    @Environment(\.presentationMode) private var presentationMode
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var currentPassword: String = ""
    @State private var newUsername: String = ""
    @State private var alertMessage: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Image("blur").ignoresSafeArea(.all))
                            .opacity(0.06)
                            .frame(height: 5)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        headerSection
                        
                        userInfoSection
                        
                        usernameUpdateSection
                        
                        currentPasswordSection
                        
                        passwordSection
                        
                        confirmPasswordSection
                        
                        if showError {
                            errorMessageView(message: alertMessage)
                                .padding(.top, 20)
                        }
                        
                        updateButton
                    }
                    .padding([.leading, .trailing], 20)
                }
                .navigationTitle("Account Info")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Account Information")
                .font(Font.custom("Gilroy-SemiBold", size: 22))
                .foregroundColor(AppColors.darkGreen)
            
            Text("Update your account details below.")
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.oliveGreen)
        }
    }
    
    private var userInfoSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Username")
                .font(Font.custom("Gilroy-SemiBold", size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            Text(authManager.username)
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
            
            Text("Email")
                .font(Font.custom("Gilroy-SemiBold", size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            Text(authManager.currentUser()?.email ?? "No email")
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
    }
    
    private var usernameUpdateSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Update Username")
                .font(Font.custom("Gilroy-SemiBold", size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            TextField("Enter new username", text: $newUsername)
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.oliveGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
                .onChange(of: newUsername) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var currentPasswordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Current Password")
                .font(Font.custom("Gilroy-SemiBold", size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Enter current password", text: $currentPassword)
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.oliveGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
                .onChange(of: currentPassword) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var passwordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New Password")
                .font(Font.custom("Gilroy-SemiBold", size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Enter new password", text: $newPassword)
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.oliveGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
                .onChange(of: newPassword) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var confirmPasswordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Confirm New Password")
                .font(Font.custom("Gilroy-SemiBold", size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Confirm new password", text: $confirmPassword)
                .font(Font.custom("Gilroy-Medium", size: 14))
                .foregroundColor(AppColors.oliveGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
                .onChange(of: confirmPassword) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var updateButton: some View {
        Button(action: handleUpdateInfo) {
            GroceryButton(text: "Update Info")
        }
        .padding(.top, 20)
    }
    
    private func handleUpdateInfo() {
        if newPassword != confirmPassword {
            alertMessage = "Passwords do not match."
            showError = true
            return
        }
        
        var hasChanges = false
        
        if !newUsername.isEmpty {
            authManager.updateProfile(username: newUsername) { result in
                switch result {
                case .success:
                    alertMessage = "Username updated successfully."
                    showError = false
                    hasChanges = true
                case .failure(let error):
                    alertMessage = error.localizedDescription
                    showError = true
                }
            }
        }
        
        if !newPassword.isEmpty {
            authManager.updatePassword(newPassword: newPassword, currentPassword: currentPassword) { result in
                switch result {
                case .success:
                    alertMessage = "Password updated successfully."
                    showError = false
                    hasChanges = true
                case .failure(let error):
                    alertMessage = error.localizedDescription
                    showError = true
                }
            }
        }
        
        if !hasChanges {
            alertMessage = "No changes to update."
            showError = true
        }
    }
    
    private func errorMessageView(message: String) -> some View {
        Text(message)
            .font(Font.custom("Gilroy-Medium", size: 14))
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}
