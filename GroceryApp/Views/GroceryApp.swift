//
//  GroceryAppApp.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 28.07.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct GroceryApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authManager = GroceryAuthManager()
    @StateObject private var dataManager = GroceryDataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
                .environmentObject(dataManager)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var authManager: GroceryAuthManager
    
    var body: some View {
        Group {
            if authManager.isCheckingStatus {
                CheckingAuthView()
            } else if authManager.isAuthenticated {
                CustomTabView()
            } else {
                LoginView()
            }
        }
    }
}

struct CheckingAuthView: View {
    var body: some View {
        VStack {
            Text("Checking Authentication...")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.9))
        .edgesIgnoringSafeArea(.all)
        .transition(.opacity)
    }
}
