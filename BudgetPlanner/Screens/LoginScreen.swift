//
//  LoginScreen.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI

struct LoginScreen: View {
    // viewmodel here to control user name and password
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool

    var body: some View {
        // IDK what sarah wants
        VStack {
            VStack {
                TextField(text: $username, label: {
                    Text("Username/Email")
                })
                .textFieldStyle(OutlinedTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(OutlinedTextFieldStyle())
            }
            .padding(.bottom, 32)
            
            Button {
                // Sign in with username & password
                isLoggedIn = true
            } label: {
                Text("Sign In")
                    .font(.title2)
            }.buttonStyle(.borderedProminent)
            Button {
                
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
        }
        .padding(30)
    }
}

#Preview {
    LoginScreen(isLoggedIn: .constant(false))
}
