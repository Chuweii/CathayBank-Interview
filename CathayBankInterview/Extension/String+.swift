//
//  String+.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

extension String {
    var formattedAmount: String {
        let number = (self as NSString).floatValue
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        formatter.roundingMode = .down
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
