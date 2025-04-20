//
//  AuthManager.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/20/25.
//

import Foundation
import FirebaseAuth

@MainActor
class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    private init() {}
    
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        try await auth.createUser(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    var currentUser: User? {
        auth.currentUser
    }
    
    func isUserLoggedIn() async throws -> Bool {
        return auth.currentUser != nil
    }
}
