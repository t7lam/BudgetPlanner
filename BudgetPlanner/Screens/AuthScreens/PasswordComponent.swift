//
//  PasswordComponent.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/20/25.
//

import SwiftUI

struct PasswordComponent: View {
    @Binding private var password: String
    @State private var isSecured: Bool = true
    
    init(password: Binding<String>) {
        self._password = password
    }
    
    var body: some View {
        VStack {
            HStack {
                if isSecured {
                    SecureField("Password", text: $password)
                } else {
                    TextField("Password", text: $password)
                }
                
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    PasswordComponent(password: .constant(""))
}
