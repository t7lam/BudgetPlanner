//
//  TransactionCell.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import SwiftUI

struct TransactionCell: View {
    let transaction: Transaction
    // viewmodel here for data
    var body: some View {
        HStack {
            // Date
            HStack {
                VStack(alignment: .leading) {
                    // Month & Date
                    Text(transaction.date)
                    Text(transaction.date)
                }
                .padding(.trailing)
                VStack(alignment: .leading) {
                    // Category
                    Text(transaction.category)
                    // typeOfTransaction
                    Text(transaction.typeOfTransaction)
                }
            }
            Spacer()
            HStack {
                // Amount
                Text(String(format: "$%.2f", transaction.amount))
                // Button
                Image(systemName: "chevron.right")
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    TransactionCell(transaction: Transaction(id: UUID(), date: "Jan. 1st 2025", amount: 101.00, category: "Account", typeOfTransaction: "Expense"))
}
