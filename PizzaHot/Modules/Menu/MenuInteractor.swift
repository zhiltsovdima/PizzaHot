//
//  MenuInteractor.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol MenuInteractorProtocol {
    func fetchFood(completion: @escaping (Result<[Food], Error>) -> Void)
    func fetchImage(for food: Food, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class MenuInteractor: MenuInteractorProtocol {
    
    private let foodService: FoodServiceProtocol
    
    private var foods = [Food]()
    
    init(foodService: FoodServiceProtocol) {
        self.foodService = foodService
    }
    
    func fetchFood(completion: @escaping (Result<[Food], Error>) -> Void) {
        foodService.getFoodData { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let foodData):
                processFoodData(foodData, completion: completion)
                foodService.saveFoodDataLocally(foodData)
            case .failure(let error):
                let loadedFoods = foodService.loadFoodDataLocally()
                processFoodData(loadedFoods, completion: completion)
                completion(.failure(error))
            }
        }
    }
    
    private func processFoodData(_ foodData: [FoodData], completion: @escaping (Result<[Food], Error>) -> Void) {
        foods = foodData.map {
            Food(name: $0.name,
                 description: $0.description,
                 category: FoodCategory.validateCategory($0.category),
                 price: "От \($0.price) р",
                 imageUrl: $0.imageUrl
            )
        }
        completion(.success(foods))
    }
    
    func fetchImage(for food: Food, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let urlString = food.imageUrl else {
            completion(.success(R.Images.defaultFood))
            return
        }
        foodService.getImage(urlString: urlString, completion: completion)
    }
}
