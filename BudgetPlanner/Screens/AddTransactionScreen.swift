//
//  AddTransactionScreen.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI

struct AddTransactionScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: TransactionsScreenViewModel
    @State private var amount: String = ""
    @State private var category: String = ""
    @State private var typeOfTransaction: String = "Expense"
    @State private var date: Date = Date()
    @State private var description: String = ""
    
    let transactionTypes = ["Expense", "Income"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount") {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section("Category") {
                    TextField("Category", text: $category)
                }
                
                Section("Type") {
                    Picker("Transaction Type", selection: $typeOfTransaction) {
                        ForEach(transactionTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Date") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section("Description (Optional)") {
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("New Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            if let amountDouble = Double(amount) {
                                await viewModel.addTransaction(
                                    amount: amountDouble,
                                    category: category,
                                    typeOfTransaction: typeOfTransaction,
                                    date: date
                                )
                            }
                            dismiss()
                        }
                    }
                }
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    AddTransactionScreen(viewModel: TransactionsScreenViewModel())
}
