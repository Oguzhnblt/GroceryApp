//
//  GroceryAuthViewModel.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import FirebaseAuth
import FirebaseFirestore


class GroceryAuthManager: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isAuthenticated: Bool = false
    @Published var isCheckingStatus: Bool = true 

    
    private var db: Firestore = Firestore.firestore()
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init() {
        checkUserStatus()
    }
    
    func checkUserStatus() {
            Auth.auth().addStateDidChangeListener { [weak self] _, user in
                DispatchQueue.main.async {
                    self?.isAuthenticated = (user != nil)
                    self?.isCheckingStatus = false
                }
            }
        }
    
    func signUp(completion: @escaping () -> Void) {
        guard !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            errorMessage = "Please provide a valid email and password (at least 6 characters)."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.isAuthenticated = true
                self?.successMessage = "Account successfully created!"
                completion()
            }
        }
    }
    
    func login(completion: @escaping () -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please provide email and password."
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.isAuthenticated = true
                completion()
            }
        }
    }
    
    func logout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            completion()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
