//
//  User.swift
//  BudgetPlanner
//
//  Created by Tommy Lam on 5/4/25.
//

import Foundation
import FirebaseFirestore

struct UserProfile: Identifiable, Codable {
    @DocumentID var id: String?
    let email: String
    let name: String
    let created_at: Date
    let categories: [String]
    let settings: UserSettings
    
    struct UserSettings: Codable {
        let default_currency: String
        let default_summary: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case created_at
        case categories
        case settings
    }
}
