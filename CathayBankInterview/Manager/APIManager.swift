//
//  APIManager.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIResult {
    case success(data: Data)
    case failure(error: Error)
}

class APIManager {
    func request(endpoint: String, method: HttpMethod, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(APIError.networkError))
            }
        }.resume()
    }
}

struct APIInfo {
    // API domain
    private static let baseDomain = "https://willywu0201.github.io/data/"
        
    public static let notificationList = baseDomain + "notificationList.json"
    public static let emptyNotificationList = baseDomain + "emptyNotificationList.json"

    public static let firstUSD = baseDomain + "usdSavings1.json"
    public static let firstUSDFixedDeposited = baseDomain + "usdFixed1.json"
    public static let firstUSDDigital = baseDomain + "usdDigital1.json"
    
    public static let refreshUSD = baseDomain + "usdSavings2.json"
    public static let refreshUSDFixedDeposited = baseDomain + "usdFixed2.json"
    public static let refreshUSDDigital = baseDomain + "usdDigital2.json"
    
    public static let firstKHR = baseDomain + "khrSavings1.json"
    public static let firstKHRFixedDeposited = baseDomain + "khrFixed1.json"
    public static let firstKHRDigital = baseDomain + "khrDigital1.json"
    
    public static let refreshKHR = baseDomain + "khrSavings2.json"
    public static let refreshKHRFixedDeposited = baseDomain + "khrFixed2.json"
    public static let refreshKHRDigital = baseDomain + "khrDigital2.json"
    
    public static let favoriteList = baseDomain + "favoriteList.json"
    public static let emptyFavoriteList = baseDomain + "emptyFavoriteList.json"
    
    public static let adBanner = baseDomain + "banner.json"
}

