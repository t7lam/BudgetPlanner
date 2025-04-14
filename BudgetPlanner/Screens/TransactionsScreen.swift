//
//  TransactionsScreen.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI

struct TransactionsScreen: View {
    @State private var showingAddTransaction = false
    @StateObject private var viewModel = TransactionsScreenViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.transactions) { transaction in
                    TransactionCell(transaction: transaction)
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Transactions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // Filter transactions
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Add new transaction
                        showingAddTransaction = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionScreen(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    TransactionsScreen()
}
