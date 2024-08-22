//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

class DataRepository {
    public static let shared = DataRepository()
    
    private func fetchData<T: Decodable>(for dataType: T.Type, endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        APIManager.shared.request(endpoint: endpoint, method: .get) { result in
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
    /// 空的 Notification
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
    
    /// 重整抓新的 NotificationData
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
    /// 第一次登入抓空的 FavoriteData
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
    /// 重整抓新的 FavoriteData
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
