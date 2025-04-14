//
//  TextfieldStyles.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//
import SwiftUI
import Foundation

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2)
            }
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(Color(UIColor.systemGray6))
            .clipShape(Capsule(style: .continuous))
    }
}
