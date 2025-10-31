//
//  DecodingRequesting.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation

// MARK: - Protocols


protocol DecodingRequesting {
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
