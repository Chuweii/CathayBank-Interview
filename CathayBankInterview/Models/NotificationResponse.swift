//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

struct NotificationResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: NotificationResultData
}

struct NotificationResultData: Codable {
    let messages: [NotificationModel]
}

struct NotificationModel: Codable {
    var status: Bool
    var updateDateTime: String
    var title: String
    var message: String
}

struct EmptyNotificationResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: EmptyData
}

struct EmptyData: Codable {
}
