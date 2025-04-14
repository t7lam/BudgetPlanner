import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            TransactionsScreen()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            
            AccountScreen()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainTabView()
} 