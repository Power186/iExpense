//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Scott on 11/4/20.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
