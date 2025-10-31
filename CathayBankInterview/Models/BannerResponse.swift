//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation

struct BannerResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: BannerResultData
}

struct BannerResultData: Codable {
    let bannerList: [BannerModel]
}

struct BannerModel: Codable, Equatable {
    var adSeqNo: Int
    var linkUrl: String
}
