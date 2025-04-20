//
//  SignUpScreenViewModel.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/20/25.
//

import SwiftUI

@MainActor
class SignUpScreenViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var matchingPassword: String = ""
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    
    private func passwordsAreMatching() -> Bool {
        return password == matchingPassword
    }
    
    private func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordStrong() -> Bool {
        // At least 8 characters, 1 uppercase, 1 lowercase, 1 number
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    func signUp() async {
        guard !email.isEmpty && !password.isEmpty && !matchingPassword.isEmpty else {
            errorMessage = "Please fill in all fields"
            showError = true
            return
        }
        
        if !isValidEmail() {
            errorMessage = "Please enter a valid email address"
            showError = true
            return
        }
        
        if !passwordsAreMatching() {
            errorMessage = "Passwords must be matching"
            showError = true
            return
        }
        
        if !isPasswordStrong() {
            errorMessage = "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number"
            showError = true
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await AuthManager.shared.signUp(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
