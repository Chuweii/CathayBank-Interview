//
//  HomeViewModel.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

class HomeViewModel {
    // MARK: - Properties
    
    let accountBalanceRepository = AccountBalanceRepository()
    let dataRepository = DataRepository()
    
    @Published var isFirstLogin: Bool = true
    @Published var usdAmount: String = ""
    @Published var khrAmount: String = ""
    @Published var favorites: [FavoriteModel] = []
    @Published var notifications: [NotificationModel] = []
    @Published var banners: [BannerModel] = []
    
    // MARK: - Methods
    
    func onAppear() async {
        await configureAmountData(isFirstLogin: isFirstLogin)
        await configureFavoriteData(isFirstLogin: isFirstLogin)
        await configureNotificationData(isFirstLogin: isFirstLogin)
        await configureBannerData()
    }

    private func configureAmountData(isFirstLogin: Bool) async {
        let usdCompletion: (Result<Float, Error>) -> Void = { [weak self] result in
            self?.handleAmountResult(result: result, isUSD: true)
        }

        let khrCompletion: (Result<Float, Error>) -> Void = { [weak self] result in
            self?.handleAmountResult(result: result, isUSD: false)
        }

        if isFirstLogin {
            accountBalanceRepository.getFirstLoginUSDBalance(completion: usdCompletion)
            accountBalanceRepository.getFirstLoginKHRBalance(completion: khrCompletion)
        } else {
            accountBalanceRepository.getRefreshUSDBalance(completion: usdCompletion)
            accountBalanceRepository.getRefreshKHRBalance(completion: khrCompletion)
        }
    }

    private func handleAmountResult(result: Result<Float, Error>, isUSD: Bool) {
        switch result {
        case .success(let amount):
            let formattedAmount = String(format: "%.2f", amount)
            if isUSD {
                usdAmount = formattedAmount
            } else {
                khrAmount = formattedAmount
            }
        case .failure(let error):
            print("Failed to fetch amount: \(error.localizedDescription)")
            if isUSD {
                usdAmount = "Error"
            } else {
                khrAmount = "Error"
            }
        }
    }
    
    private func configureFavoriteData(isFirstLogin: Bool) async {
        if isFirstLogin {
            getFirstLoginEmptyFavoriteData { _ in
                self.favorites = []
            }
        } else {
            getRefreshFavoriteData { result in
                self.favorites = result
            }
        }
    }
    
    private func getFirstLoginEmptyFavoriteData(completion: @escaping ([FavoriteModel]) -> Void) {
        dataRepository.getFirstLoginEmptyFavoriteData { result in
            switch result {
            case .success(let favoriteArray):
                completion(favoriteArray)
            case .failure:
                completion([])
            }
        }
    }
    
    private func getRefreshFavoriteData(completion: @escaping ([FavoriteModel]) -> Void) {
        dataRepository.getRefreshFavoriteData { result in
            switch result {
            case .success(let favoriteArray):
                completion(favoriteArray)
            case .failure:
                completion([])
            }
        }
    }
    
    private func configureNotificationData(isFirstLogin: Bool) async {
        if isFirstLogin {
            fetchNotificationData(fetchData: dataRepository.getEmptyNotificationData) { result in
                self.notifications = result
            }
        } else {
            fetchNotificationData(fetchData: dataRepository.getRefreshNotificationData) { result in
                self.notifications = result
            }
        }
    }

    private func fetchNotificationData(fetchData: (@escaping (Result<[NotificationModel], Error>) -> Void) -> Void, completion: @escaping ([NotificationModel]) -> Void) {
        fetchData { result in
            switch result {
            case .success(let notificationArray):
                completion(notificationArray)
            case .failure:
                completion([])
            }
        }
    }

    private func configureBannerData() async {
        dataRepository.getBannerData { result in
            switch result {
            case .success(let bannerArray):
                self.banners = bannerArray
            case .failure:
                return
            }
        }
    }
}
