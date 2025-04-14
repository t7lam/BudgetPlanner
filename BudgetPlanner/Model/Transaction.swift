//
//  Transaction.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID?
    let date: String
    let amount: Double
    let category: String
    let typeOfTransaction: String
}
