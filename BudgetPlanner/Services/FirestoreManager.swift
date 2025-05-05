//
//  FirestoreManager.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 5/4/25.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: - User Operations
    func createUserDocument(userId: String, email: String, name: String) async throws {
        let userData: [String: Any] = [
            "email": email,
            "name": name,
            "created_at": FieldValue.serverTimestamp(),
            "categories": ["Groceries", "Transportation", "Entertainment", "Bills", "Income"],
            "settings": [
                "default_currency": "USD",
                "default_summary": "month"
            ]
        ]
        
        try await db.collection("users").document(userId).setData(userData)
    }
    
    func getUserDocument(userId: String) async throws -> UserProfile? {
        let document = try await db.collection("users").document(userId).getDocument()
        return try document.data(as: UserProfile.self)
    }
    
    // MARK: - Transaction Operations
    func addTransaction(transaction: Transaction) async throws -> DocumentReference {
        // Create a new document reference
        let docRef = db.collection("transactions").document()
        
        // Create a dictionary with all transaction data including the id
        let transactionData: [String: Any] = [
            "id": docRef.documentID,
            "user_id": transaction.user_id,
            "date": transaction.date,
            "amount": transaction.amount,
            "category": transaction.category,
            "type_of_transaction": transaction.type_of_transaction,
            "description": transaction.description as Any,
            "created_at": transaction.created_at
        ]
        
        // Set the data with the document reference
        try await docRef.setData(transactionData)
        return docRef
    }
    
    func getTransactions(userId: String) async throws -> [Transaction] {
        let query = db.collection("transactions")
            .whereField("user_id", isEqualTo: userId)
        
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.compactMap { document in
            try document.data(as: Transaction.self)
        }
    }
    
    func getTransactionsByCategory(userId: String, category: String) async throws -> [Transaction] {
        let query = db.collection("transactions")
            .whereField("user_id", isEqualTo: userId)
            .whereField("category", isEqualTo: category)
            .order(by: "date", descending: true)
        
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.compactMap { document in
            try document.data(as: Transaction.self)
        }
    }
    
    func deleteTransaction(transactionId: String) async throws {
        try await db.collection("transactions").document(transactionId).delete()
    }
    
    func updateTransaction(transactionId: String, data: [String: Any]) async throws {
        try await db.collection("transactions").document(transactionId).updateData(data)
    }
    
    // MARK: - Helper Methods
    func getTransactionsForTimePeriod(userId: String, startDate: Date, endDate: Date) async throws -> [Transaction] {
        let query = db.collection("transactions")
            .whereField("user_id", isEqualTo: userId)
            .whereField("date", isGreaterThanOrEqualTo: startDate)
            .whereField("date", isLessThan: endDate)
            .order(by: "date", descending: true)
        
        let snapshot = try await query.getDocuments()
        return try snapshot.documents.compactMap { document in
            try document.data(as: Transaction.self)
        }
    }
}
