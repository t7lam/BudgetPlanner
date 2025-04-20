//
//  SignUpScreen.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/20/25.
//

import SwiftUI

struct SignUpScreen: View {
    @StateObject private var viewModel = SignUpScreenViewModel()
    @EnvironmentObject private var appViewModel: AppViewModel

    var body: some View {
        VStack {
            VStack {
                Text("Sign Up With Email")
                TextField(text: $viewModel.email, label: {
                    Text("Email")
                })
                .textCase(.lowercase)
                .autocapitalization(.none)
                .textFieldStyle(OutlinedTextFieldStyle())
                .padding(.horizontal)
                
                // Set Password
                PasswordComponent(password: $viewModel.password)
                // Matching Password
                PasswordComponent(password: $viewModel.matchingPassword)
            }
            .padding(.bottom, 30)
            Button {
                Task {
                    await viewModel.signUp()
                    await appViewModel.checkAuthStatus()
                }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .alert("Sign Up Error", isPresented: $viewModel.showError) {
                Button("OK") {}
            }
        }
    }
}

#Preview {
    SignUpScreen()
        .environmentObject(AppViewModel())
}
