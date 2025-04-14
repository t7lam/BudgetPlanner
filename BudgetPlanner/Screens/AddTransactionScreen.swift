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
                        // Save transaction
                        if let amountDouble = Double(amount) {
                            viewModel.addTransaction(
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
    }
}

#Preview {
    AddTransactionScreen(viewModel: TransactionsScreenViewModel())
}
