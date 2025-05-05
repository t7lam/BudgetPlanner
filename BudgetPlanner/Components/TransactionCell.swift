//
//  TransactionCell.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI

struct TransactionCell: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            // Date
            HStack {
                VStack(alignment: .leading) {
                    // Month & Date
                    Text(transaction.date, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
                VStack(alignment: .leading) {
                    // Category
                    Text(transaction.category)
                        .font(.headline)
                    // Type of transaction
                    Text(transaction.type_of_transaction)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            HStack {
                // Amount
                Text(String(format: "$%.2f", transaction.amount))
                    .font(.headline)
                    .foregroundColor(transaction.type_of_transaction == "Expense" ? .red : .green)
                // Button
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TransactionCell(transaction: Transaction(
        id: nil,
        user_id: "test",
        date: Date(),
        amount: 101.00,
        category: "Groceries",
        type_of_transaction: "Expense",
        description: nil,
        created_at: Date()
    ))
}
