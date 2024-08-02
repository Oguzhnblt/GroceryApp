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
    
    var body: some View {
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
            }
        }
        
        VStack(alignment: .leading, spacing: 30) {
            headerSection
            
            usernameSection
            
            emailSection
            
            passwordSection
            
            Text("By continuing you agree to our Terms of Service\nand Privacy Policy.")
                .font(Font.custom("Gilroy-Medium", size: 12))
                .tracking(0.70)
                .lineSpacing(15.41)
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            actionButtons
            
            
        }
        .padding([.leading, .trailing], 25)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Loging")
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
            
            TextField("Enter your email", text: $email)
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            Divider()
        }
    }
    
    private var passwordSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Password")
                .font(Font.custom("Gilroy-SemiBold", size: 16))
                .foregroundColor(Color(red: 0.49, green: 0.49, blue: 0.49))
            
            SecureField("Password", text: $password)
                .font(Font.custom("Gilroy-Medium", size: 18))
                .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
            
            Divider()
        }
    }
    
    
    private var actionButtons: some View {
        VStack(alignment: .center, spacing: 20) {
            Button(action: {
                // Log in
            }) {
                GroceryButton(text: "Signup")
            }
            
            HStack {
                Text("Already have an account?")
                    .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                    .foregroundColor(Color(red: 0.09, green: 0.09, blue: 0.15))
                
                Button(action: {
                    // Signup
                }) {
                    Text("Login")
                        .font(Font.custom("Gilroy", size: 14).weight(.semibold))
                        .foregroundColor(Color(red: 0.33, green: 0.69, blue: 0.46))
                }
            }
        }
    }
}

#Preview {
    SignupView()
}
