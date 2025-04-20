//
//  AppViewModel.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/20/25.
//

import SwiftUI

@MainActor
class AppViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
     
    init() {
        Task {
            await checkAuthStatus()
        }
    }
    
    func checkAuthStatus() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            isLoggedIn = try await AuthManager.shared.isUserLoggedIn()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func signOut() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await AuthManager.shared.signOut()
            isLoggedIn = false
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
