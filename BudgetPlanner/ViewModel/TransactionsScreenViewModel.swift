//
//  TransactionsScreenViewModel.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import Foundation

import Foundation

@MainActor
class TransactionsScreenViewModel: ObservableObject {
    @Published var transactions: [Transaction] = [
        Transaction(id: UUID(), date: "Jan 1 2025", amount: 101.00, category: "Account", typeOfTransaction: "Expense"),
        Transaction(id: UUID(), date: "Jan 2 2025", amount: 201.00, category: "Account", typeOfTransaction: "Expense")
    ]
    
    func addTransaction(amount: Double, category: String, typeOfTransaction: String, date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d yyyy"
        let dateString = dateFormatter.string(from: date)
        
        let newTransaction = Transaction(
            id: UUID(),
            date: dateString,
            amount: amount,
            category: category,
            typeOfTransaction: typeOfTransaction
        )
        
        transactions.append(newTransaction)
    }
}
