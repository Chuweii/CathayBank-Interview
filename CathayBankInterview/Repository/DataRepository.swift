//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

final class DataRepository {
    private let apiManager: APIManager = .init()
    
    private func fetchData<T: Decodable>(for dataType: T.Type, endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        APIManager().request(endpoint: endpoint, method: .get) { result in
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
    
    //MARK: - Notification
    
    func getEmptyNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        let notificationURL = APIInfo.emptyNotificationList
        
        fetchData(for: NotificationResponse.self, endpoint: notificationURL) { result in
            switch result {
            case .success(let response):
                let notificationArray = response.result.messages
                completion(.success(notificationArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRefreshNotificationData(completion: @escaping (Result<[NotificationModel], Error>) -> Void) {
        let notificationURL = APIInfo.notificationList
        
        fetchData(for: NotificationResponse.self, endpoint: notificationURL) { result in
            switch result {
            case .success(let response):
                let notificationArray = response.result.messages
                completion(.success(notificationArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Favorite
    
    func getFirstLoginEmptyFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
        let favoriteURL = APIInfo.emptyFavoriteList
        
        fetchData(for: FavoriteResponse.self, endpoint: favoriteURL) { result in
            switch result {
            case .success(let response):
                let favoriteArray = response.result.favoriteList
                completion(.success(favoriteArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRefreshFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
        let favoriteURL = APIInfo.favoriteList
        
        fetchData(for: FavoriteResponse.self, endpoint: favoriteURL) { result in
            switch result {
            case .success(let response):
                let favoriteArray = response.result.favoriteList
                completion(.success(favoriteArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Banner
    
    func getBannerData(completion: @escaping (Result<[BannerModel], Error>) -> Void) {
        let adBannerURL = APIInfo.adBanner
        
        fetchData(for: BannerResponse.self, endpoint: adBannerURL) { result in
            switch result {
            case .success(let response):
                let bannerList = response.result.bannerList
                completion(.success(bannerList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
