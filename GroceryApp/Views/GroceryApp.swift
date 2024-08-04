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
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct GroceryApp: App {
    @State private var isSplashActive = true
    @StateObject private var authManager = GroceryAuthManager()
    @StateObject private var dataManager = GroceryDataManager() 
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if authManager.isCheckingStatus {
                SplashView(isSplashActive: $isSplashActive)
                    .environmentObject(authManager)
                    .environmentObject(dataManager)
            } else if authManager.isAuthenticated {
                CustomTabView()
                    .environmentObject(authManager)
                    .environmentObject(dataManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
                    .environmentObject(dataManager)
            }
        }
    }
}
