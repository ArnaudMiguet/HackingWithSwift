//
//  File.swift
//  Project07-iExpense
//
//  Created by Arnaud Miguet on 24.01.21.
//

import Foundation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let type: String
    let amount: Int
    
    var itemColor: Color {
        switch amount {
        case 100...:
            return Color.red
        case 10..<100:
            return Color.orange
        default:
            return Color.green
        }
    }
    
    init(name: String, type: String, amount: Int) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.amount = amount
    }
}
