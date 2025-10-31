//
//  FavoriteRepository.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/31.
//


protocol FavoriteRepositoryProtocol {
    func getFirstLoginEmptyFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void)
    func getRefreshFavoriteData(completion: @escaping (Result<[FavoriteModel], Error>) -> Void)
}


class FavoriteRepository: FavoriteRepositoryProtocol, DecodingRequesting {
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
