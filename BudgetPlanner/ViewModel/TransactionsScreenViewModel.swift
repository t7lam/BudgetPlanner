//
//  TransactionsScreenViewModel.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import Foundation

@MainActor
class TransactionsScreenViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    func addTransaction(amount: Double, category: String, typeOfTransaction: String, date: Date, description: String?) async {
        guard let userId = AuthManager.shared.currentUser?.uid else { return }
        
        let newTransaction = Transaction(
            id: nil, // Firestore will generate this
            user_id: userId,
            date: date,
            amount: amount,
            category: category,
            type_of_transaction: typeOfTransaction,
            description: description,
            created_at: Date()
        )
        
        do {
            let docRef = try await FirestoreManager.shared.addTransaction(transaction: newTransaction)
            // Update the transaction with the document ID
            var updatedTransaction = newTransaction
            updatedTransaction.id = docRef.documentID
            await fetchTransactions()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func fetchTransactions() async {
        guard let userId = AuthManager.shared.currentUser?.uid else { return }
        
        do {
            var fetchedTransactions = try await FirestoreManager.shared.getTransactions(userId: userId)
            // Sort transactions by date in descending order
            fetchedTransactions.sort { $0.date > $1.date }
            transactions = fetchedTransactions
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func deleteTransaction(_ transaction: Transaction) async {
        guard let transactionId = transaction.id else { return }
        
        do {
            try await FirestoreManager.shared.deleteTransaction(transactionId: transactionId)
            await fetchTransactions()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
