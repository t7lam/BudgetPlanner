//
//  AccountScreenViewModel.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/20/25.
//

import SwiftUI

@MainActor
class AccountScreenViewModel: ObservableObject {
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    func signOut() async {
        do {
            try await AuthManager.shared.signOut()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
