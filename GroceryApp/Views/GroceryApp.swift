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
    
    @EnvironmentObject private var authManager: GroceryAuthManager
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if isSplashActive {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isSplashActive = false
                            }
                        }
                    }
            } else {
                LoginView()
                    .environmentObject(GroceryAuthManager())
            }
        }
    }
}
