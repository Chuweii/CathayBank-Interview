//
//  BannerRepository.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/31.
//


protocol BannerRepositoryProtocol {
    func getBannerData(completion: @escaping (Result<[BannerModel], Error>) -> Void)
}


class BannerRepository: BannerRepositoryProtocol, DecodingRequesting {
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
