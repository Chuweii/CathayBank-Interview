//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation

// MARK: - Protocol

protocol AccountBalanceRepositoryProtocol {
    func getFirstLoginUSDBalance(completion: @escaping (Result<Float, Error>) -> Void)
    func getFirstLoginKHRBalance(completion: @escaping (Result<Float, Error>) -> Void)
    func getRefreshUSDBalance(completion: @escaping (Result<Float, Error>) -> Void)
    func getRefreshKHRBalance(completion: @escaping (Result<Float, Error>) -> Void)
}

// MARK: - Implementation

final class AccountBalanceRepository: AccountBalanceRepositoryProtocol {    
    private let apiManager: APIManager

    init(apiManager: APIManager = .init()) {
        self.apiManager = apiManager
    }

    private func getTotalBalance(for endpoint: String, completion: @escaping (Result<Float, Error>) -> Void) {
        apiManager.request(endpoint: endpoint, method: .get) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let amountResponse = try decoder.decode(AmountResponse.self, from: data)
                    
                    if let resultList = amountResponse.result.first?.value {
                        let totalBalance = resultList.reduce(0.0) { $0 + $1.balance }
                        completion(.success(totalBalance))
                    } else {
                        completion(.success(0.0))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getFirstLoginUSDBalance(completion: @escaping (Result<Float, Error>) -> Void) {
        let savingsURL = APIInfo.firstUSD
        let fixedDepositsURL = APIInfo.firstUSDFixedDeposited
        let digitalAccountsURL = APIInfo.firstUSDDigital
        
        let dispatchGroup = DispatchGroup()
        var totalBalances: [Float] = []
        var firstError: Error?
        
        dispatchGroup.enter()
        getTotalBalance(for: savingsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: fixedDepositsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: digitalAccountsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = firstError {
                completion(.failure(error))
            } else {
                let totalSum = totalBalances.reduce(0.0, +)
                completion(.success(totalSum))
            }
        }
    }
    
    func getFirstLoginKHRBalance(completion: @escaping (Result<Float, Error>) -> Void) {
        let savingsURL = APIInfo.firstKHR
        let fixedDepositsURL = APIInfo.firstKHRFixedDeposited
        let digitalAccountsURL = APIInfo.firstKHRDigital
        
        let dispatchGroup = DispatchGroup()
        var totalBalances: [Float] = []
        var firstError: Error?
        
        dispatchGroup.enter()
        getTotalBalance(for: savingsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: fixedDepositsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: digitalAccountsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = firstError {
                completion(.failure(error))
            } else {
                let totalSum = totalBalances.reduce(0.0, +)
                completion(.success(totalSum))
            }
        }
    }
    
    func getRefreshUSDBalance(completion: @escaping (Result<Float, Error>) -> Void) {
        let savingsURL = APIInfo.refreshUSD
        let fixedDepositsURL = APIInfo.refreshUSDFixedDeposited
        let digitalAccountsURL = APIInfo.refreshUSDDigital
        
        let dispatchGroup = DispatchGroup()
        var totalBalances: [Float] = []
        var firstError: Error?
        
        dispatchGroup.enter()
        getTotalBalance(for: savingsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: fixedDepositsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: digitalAccountsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = firstError {
                completion(.failure(error))
            } else {
                let totalSum = totalBalances.reduce(0.0, +)
                completion(.success(totalSum))
            }
        }
    }
    
    func getRefreshKHRBalance(completion: @escaping (Result<Float, Error>) -> Void) {
        let savingsURL = APIInfo.refreshKHR
        let fixedDepositsURL = APIInfo.refreshKHRFixedDeposited
        let digitalAccountsURL = APIInfo.refreshKHRDigital
        
        let dispatchGroup = DispatchGroup()
        var totalBalances: [Float] = []
        var firstError: Error?
        
        dispatchGroup.enter()
        getTotalBalance(for: savingsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: fixedDepositsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getTotalBalance(for: digitalAccountsURL) { result in
            switch result {
            case .success(let totalBalance):
                totalBalances.append(totalBalance)
            case .failure(let error):
                firstError = firstError ?? error
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            if let error = firstError {
                completion(.failure(error))
            } else {
                let totalSum = totalBalances.reduce(0.0, +)
                completion(.success(totalSum))
            }
        }
    }
}
