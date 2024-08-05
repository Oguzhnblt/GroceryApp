//
//  GroceryAuthViewModel.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthResult {
    case success
    case failure(Error)
}

class GroceryAuthManager: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var isAuthenticated: Bool = false
    @Published var isCheckingStatus: Bool = true
    @Published var isEmailVerified: Bool = false
    
    private var db: Firestore = Firestore.firestore()
    
    init() {
        checkUserStatus()
    }
    
    func checkUserStatus() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                if let user = user {
                    self?.isAuthenticated = true
                    self?.isEmailVerified = user.isEmailVerified
                    self?.username = user.displayName ?? ""
                } else {
                    self?.isAuthenticated = false
                    self?.isEmailVerified = false
                    self?.username = ""
                }
                self?.isCheckingStatus = false
            }
        }
    }
    
    func signUp(completion: @escaping (AuthResult) -> Void) {
        guard !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            errorMessage = "Please provide a valid email and password (at least 6 characters)."
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage ?? ""])))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
            } else {
                self?.isAuthenticated = true
                self?.successMessage = "Account successfully created!"
                self?.sendVerificationEmail { result in
                    switch result {
                    case .success:
                        self?.successMessage = "Verification email sent. Please verify your email."
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                }
                completion(.success)
            }
        }
    }
    
    func login(completion: @escaping (AuthResult) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please provide email and password."
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage ?? ""])))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
            } else {
                self?.isAuthenticated = true
                self?.checkUserStatus()
                completion(.success)
            }
        }
    }
    
    func logout(completion: @escaping (AuthResult) -> Void) {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            isEmailVerified = false
            username = ""
            completion(.success)
        } catch {
            errorMessage = error.localizedDescription
            completion(.failure(error))
        }
    }
    
    func updateProfile(username: String, completion: @escaping (AuthResult) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is logged in."])))
            return
        }
        
        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = username
        
        changeRequest.commitChanges { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.username = username
                completion(.success)
            }
        }
    }
    
    func updateEmail(newEmail: String, currentPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is logged in."])))
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email ?? "", password: currentPassword)

        currentUser.reauthenticate(with: credential) { [weak self] result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            currentUser.updateEmail(to: newEmail) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                currentUser.sendEmailVerification { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self?.isEmailVerified = false
                        completion(.success(()))
                    }
                }
            }
        }
    }

    func updatePassword(newPassword: String, currentPassword: String, completion: @escaping (AuthResult) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is logged in."])))
            return
        }
        
        reauthenticateUser(currentPassword: currentPassword) { result in
            switch result {
            case .success:
                currentUser.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success)
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func reauthenticateUser(currentPassword: String, completion: @escaping (AuthResult) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is logged in."])))
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email ?? "", password: currentPassword)
        currentUser.reauthenticate(with: credential) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success)
            }
        }
    }
    
    func sendVerificationEmail(completion: @escaping (AuthResult) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "GroceryAuthManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is logged in."])))
            return
        }
        
        currentUser.sendEmailVerification { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success)
            }
        }
    }
    
    func currentUser() -> User? {
        return Auth.auth().currentUser
    }
}
