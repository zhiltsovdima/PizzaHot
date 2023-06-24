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
    func saveFoodDataLocally(_ foodData: [FoodData])
    func loadFoodDataLocally() -> [FoodData]
}

final class FoodService {
    
    private let networkManager: NetworkManagerProtocol
    
    private var imageCache = NSCache<NSURL, UIImage>()
        
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
        if let cachedImage = imageCache.object(forKey: imageUrl as NSURL) {
            completion(.success(cachedImage))
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
    
    func saveFoodDataLocally(_ foodData: [FoodData]) {
        let encodedResult = DataCoder.encode(foodData)
        switch encodedResult {
        case .success(let encodedData):
            UserDefaults.standard.set(encodedData, forKey: "foodData")
        case .failure(let error):
            print(error.description)
        }
    }
    
    func loadFoodDataLocally() -> [FoodData] {
        guard let encodedData = UserDefaults.standard.data(forKey: "foodData") else { return [] }
        let decodedResult = DataCoder.decode(type: [FoodData].self, from: encodedData)
        switch decodedResult {
        case .success(let decodedData):
            return decodedData
        case .failure(let error):
            print(error.description)
            return []
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
        imageCache.setObject(image, forKey: imageURL as NSURL)
        completion(.success(image))
    }
}
