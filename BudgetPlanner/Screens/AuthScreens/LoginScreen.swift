//
//  LoginScreen.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI
import FirebaseAuth

struct LoginScreen: View {
    // viewmodel here to control user name and password
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var appViewModel: AppViewModel

    var body: some View {
        // IDK what sarah wants
        NavigationStack {
            VStack {
                VStack {
                    TextField(text: $viewModel.email, label: {
                        Text("Username/Email")
                    })
                    .textCase(.lowercase)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .textFieldStyle(OutlinedTextFieldStyle())
                    PasswordComponent(password: $viewModel.password)
                }
                .padding(.bottom, 32)
                
                Button {
                    // Sign in with username & password
                    Task {
                        await viewModel.login()
                        await appViewModel.checkAuthStatus()
                    }
                } label: {
                    Text("Sign In")
                        .font(.title2)
                }
                .buttonStyle(.borderedProminent)
                .alert("Login Error", isPresented: $viewModel.showError) {
                    Button("OK") {}
                } message: {
                    Text(viewModel.errorMessage)
                }
                NavigationLink {
                    SignUpScreen()
                } label: {
                    Text("Sign Up")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AppViewModel())
}
