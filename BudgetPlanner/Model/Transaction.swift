//
//  Transaction.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 4/13/25.
//

import Foundation
import FirebaseFirestore

struct Transaction: Identifiable, Codable {
    @DocumentID var id: String?
    let user_id: String
    let date: Date
    let amount: Double
    let category: String
    let type_of_transaction: String
    let description: String?
    let created_at: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case user_id
        case date
        case amount
        case category
        case type_of_transaction
        case description
        case created_at
    }
}
