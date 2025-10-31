//
//  NotificationRepository.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/31.
//


protocol NotificationRepositoryProtocol {
    func getEmptyNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
    func getRefreshNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
}


class NotificationRepository: NotificationRepositoryProtocol, DecodingRequesting {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    func getEmptyNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        let endpoint = APIInfo.emptyNotificationList
        fetchData(for: NotificationResponse.self, endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result.messages))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getRefreshNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        let endpoint = APIInfo.notificationList
        fetchData(for: NotificationResponse.self, endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result.messages))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
