//
//  GroceryAuthManager.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 2.08.2024.
//

import FirebaseAuth

func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
        if let error = error {
            completion(.failure(error))
        } else if let user = result?.user {
            completion(.success(user))
        }
    }
}

func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        if let error = error {
            completion(.failure(error))
        } else if let user = result?.user {
            completion(.success(user))
        }
    }
}

func logout() {
    do {
        try Auth.auth().signOut()
    } catch let signOutError as NSError {
        print("Error signing out: %@", signOutError)
    }
}

func checkUserStatus() -> User? {
    return Auth.auth().currentUser
}

