//
//  BudgetPlannerApp.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI

@main
struct BudgetPlannerApp: App {
    @State private var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
            } else {
                LoginScreen(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
