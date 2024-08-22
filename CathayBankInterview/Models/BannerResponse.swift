//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
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
