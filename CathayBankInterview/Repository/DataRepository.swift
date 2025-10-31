//
//  Repositories.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

// MARK: - Protocols

protocol NotificationRepositoryProtocol {
    func getEmptyNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
    func getRefreshNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void)
}

protocol FavoriteRepositoryProtocol {
    func getFirstLoginEmptyFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void)
    func getRefreshFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void)
}

protocol BannerRepositoryProtocol {
    func getBannerData(completion: @escaping (Result<[BannerModel], Error>) -> Void)
}

// MARK: - Base helper (optional common decoding)

private protocol DecodingRequesting {
    var apiManager: APIManager { get }
    func fetchData<T: Decodable>(for dataType: T.Type, endpoint: String, completion: @escaping (Result<T, Error>) -> Void)
}

extension DecodingRequesting {
    func fetchData<T: Decodable>(for dataType: T.Type, endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        apiManager.request(endpoint: endpoint, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - NotificationRepository

final class NotificationRepository: NotificationRepositoryProtocol, DecodingRequesting {
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

// MARK: - FavoriteRepository

final class FavoriteRepository: FavoriteRepositoryProtocol, DecodingRequesting {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    func getFirstLoginEmptyFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
        let endpoint = APIInfo.emptyFavoriteList
        fetchData(for: FavoriteResponse.self, endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result.favoriteList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getRefreshFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
        let endpoint = APIInfo.favoriteList
        fetchData(for: FavoriteResponse.self, endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result.favoriteList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - BannerRepository

final class BannerRepository: BannerRepositoryProtocol, DecodingRequesting {
    let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    func getBannerData(completion: @escaping (Result<[BannerModel], Error>) -> Void) {
        let endpoint = APIInfo.adBanner
        fetchData(for: BannerResponse.self, endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result.bannerList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
