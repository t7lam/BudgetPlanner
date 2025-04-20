//
//  BudgetPlannerApp.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI
import FirebaseCore

@main
struct BudgetPlannerApp: App {
    @StateObject private var appViewModel = AppViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if appViewModel.isLoggedIn {
                MainTabView()
            } else {
                LoginScreen()
            }
        }
        .environmentObject(appViewModel)
    }
}
