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
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    userInfoSection
                    usernameUpdateSection
                    currentPasswordSection
                    passwordSection
                    confirmPasswordSection
                    
                    if showError {
                        errorMessageView(message: alertMessage)
                            .padding(.top, 10)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.5), value: showError)
                    }
                    
                    updateButton
                }
                .padding([.leading, .trailing], 20)
                .padding(.top, 30)
            }
            .onChange(of: alertMessage) {
                if !alertMessage.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            showError = false
                        }
                    }
                }
            }
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Account Information")
                .font(AppFonts.gilroySemiBold(size: 24))
                .foregroundColor(AppColors.darkGreen)
            
            Text("Update your account details below.")
                .font(AppFonts.gilroyMedium(size: 14))
                .foregroundColor(AppColors.oliveGreen)
        }
    }
    
    private var userInfoSection: some View {
            HStack(spacing: 10) {
                infoCard(title: "Username", content: authManager.username)
                infoCard(title: "Email", content: authManager.currentUser()?.email ?? "No email")
            }
        .padding(.vertical, 10)
    }
    
    private func infoCard(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(AppFonts.gilroySemiBold(size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            Text(content)
                .font(AppFonts.gilroyMedium(size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.oliveGreen, lineWidth: 1)
                )
        }
        .padding(.bottom, 10)
    }
    
    private var usernameUpdateSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Update Username")
                .font(AppFonts.gilroySemiBold(size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            TextField("Enter new username", text: $newUsername)
                .font(AppFonts.gilroyMedium(size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.oliveGreen, lineWidth: 1)
                )
                .onChange(of: newUsername) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var currentPasswordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Current Password")
                .font(AppFonts.gilroySemiBold(size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Enter current password", text: $currentPassword)
                .font(AppFonts.gilroyMedium(size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.oliveGreen, lineWidth: 1)
                )
                .onChange(of: currentPassword) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var passwordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New Password")
                .font(AppFonts.gilroySemiBold(size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Enter new password", text: $newPassword)
                .font(AppFonts.gilroyMedium(size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.oliveGreen, lineWidth: 1)
                )
                .onChange(of: newPassword) {
                    alertMessage = ""
                    showError = false
                }
        }
    }
    
    private var confirmPasswordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Confirm New Password")
                .font(AppFonts.gilroySemiBold(size: 14))
                .foregroundColor(AppColors.oliveGreen)
            
            SecureField("Confirm new password", text: $confirmPassword)
                .font(AppFonts.gilroyMedium(size: 14))
                .foregroundColor(AppColors.darkGreen)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppColors.oliveGreen, lineWidth: 1)
                )
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
        .padding(.top, 25)
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
                    showError = true
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
                    showError = true
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
            .padding()
            .background(Color.white)
            .cornerRadius(8)
    }
}
