//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation

struct FavoriteResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: FavoriteResultData
}

struct FavoriteResultData: Codable {
    let favoriteList: [FavoriteModel]
}

struct FavoriteModel: Codable, Equatable {
    let nickname: String
    let transType: String
}
