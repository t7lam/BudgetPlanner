import SwiftUI

struct TransactionListView: View {
    let transactions: [Transaction]
    
    var body: some View {
        List {
            ForEach(transactions) { transaction in
                TransactionRow(transaction: transaction)
                    .listRowSeparator(.hidden)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.3))
                            .padding(.leading)
                            .padding(.trailing)
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                    )
            }
        }
        .listStyle(.plain)
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.category)
                    .font(.headline)
                Text(transaction.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("$\(transaction.amount, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(transaction.type_of_transaction == "Expense" ? .red : .green)
        }
        .padding(.vertical, 4)
    }
} 