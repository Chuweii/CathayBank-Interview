//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation

struct AmountResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: [String: [AmountModel]]
}

struct AmountModel: Codable {
    let account: String
    let curr: String
    let balance: Float
}
