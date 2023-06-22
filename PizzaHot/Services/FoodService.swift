//
//  FoodService.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol FoodServiceProtocol: AnyObject {
    func getFoodData(completion: @escaping (Result<[FoodData], Error>) -> Void)
    func getImage(urlString: String, completion: @escaping ((Result<UIImage, Error>) -> Void))
}

final class FoodService {
    
    private let networkManager: NetworkManagerProtocol
        
    init(_ networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: - FoodServiceProtocol

extension FoodService: FoodServiceProtocol {
    
    func getFoodData(completion: @escaping (Result<[FoodData], Error>) -> Void) {
        networkManager.fetchData(apiEndpoint: .food) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let foodData):
                parseData(foodData, completion: completion)
            case .failure(let netError):
                completion(.failure(netError))
            }
        }
    }
    
    func getImage(urlString: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let imageUrl = URL(string: urlString) else {
            completion(.failure(NetworkError.wrongURL))
            return
        }
        networkManager.fetchData(url: imageUrl) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                processImageData(data, imageURL: imageUrl, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Private Methods

extension FoodService {
    private func parseData<T: Decodable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let parseResult = DataCoder.decode(type: T.self, from: data)
        switch parseResult {
        case .success(let weatherData):
            completion(.success(weatherData))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func processImageData(_ data: Data, imageURL: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        guard let image = UIImage(data: data) else {
            completion(.failure(DataCodingError.decodingToImageFailed))
            return
        }
        completion(.success(image))
    }
}
