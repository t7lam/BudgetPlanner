import SwiftUI

struct AccountScreen: View {
    @EnvironmentObject private var appViewModel: AppViewModel
    @StateObject private var viewModel = AccountScreenViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Account Screen")
                Button {
                    Task {
                        await viewModel.signOut()
                        await appViewModel.checkAuthStatus()
                    }
                } label: {
                    Text("Sign Out")
                }
            }
            .navigationTitle("Account")
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    AccountScreen()
        .environmentObject(AppViewModel())
}
