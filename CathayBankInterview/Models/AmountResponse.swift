//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
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
