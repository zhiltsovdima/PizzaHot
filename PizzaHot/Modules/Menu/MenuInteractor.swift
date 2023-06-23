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
    
    private var foods = [
        Food(name: "Ветчина и грибы", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/thinly-sliced-pepperoni-is-a-popular-pizza-topping-in-american-style-pizzerias-isolated-on-white-background-still-life_639032-229.jpg?w=1380&t=st=1687499254~exp=1687499854~hmac=4ea4df180e3d32b561201250155cac98716a65cba76f59768036952d785c7294"),
        Food(name: "Баварские колбаски", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/thinly-sliced-pepperoni-is-a-popular-pizza-topping-in-american-style-pizzerias-isolated-on-white-background-still-life_639032-229.jpg?w=1380&t=st=1687499254~exp=1687499854~hmac=4ea4df180e3d32b561201250155cac98716a65cba76f59768036952d785c7294"),
        Food(name: "Нежный лосось", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/delicious-italian-food_1147-165.jpg?w=1380&t=st=1687499300~exp=1687499900~hmac=93c90ae954dbaaee3b10218c80ad949cc13eed6c77b294b1467521abd8278bf5"),
        Food(name: "Пицца четыре сыра", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/delicious-italian-food_1147-165.jpg?w=1380&t=st=1687499300~exp=1687499900~hmac=93c90ae954dbaaee3b10218c80ad949cc13eed6c77b294b1467521abd8278bf5"),
        Food(name: "Пицца четыре сыра", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/delicious-italian-food_1147-165.jpg?w=1380&t=st=1687499300~exp=1687499900~hmac=93c90ae954dbaaee3b10218c80ad949cc13eed6c77b294b1467521abd8278bf5"),
        Food(name: "Пицца четыре сыра", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/delicious-italian-food_1147-165.jpg?w=1380&t=st=1687499300~exp=1687499900~hmac=93c90ae954dbaaee3b10218c80ad949cc13eed6c77b294b1467521abd8278bf5"),
        Food(name: "Пицца четыре сыра", description: "Ветчина, шампиньоны, увеличенная порция мацарелы, томатный соус", category: .pizza, price: "От 345 р", imageUrl: "https://img.freepik.com/free-photo/delicious-italian-food_1147-165.jpg?w=1380&t=st=1687499300~exp=1687499900~hmac=93c90ae954dbaaee3b10218c80ad949cc13eed6c77b294b1467521abd8278bf5"),
        Food(name: "Apple pie", description: "Вкусный", category: .desserts, price: "От 345 р", imageUrl: nil),
    ]
    
    init(foodService: FoodServiceProtocol) {
        self.foodService = foodService
    }
    
    func fetchFood(completion: @escaping (Result<[Food], Error>) -> Void) {
        completion(.success(foods))
//        foodService.getFoodData { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success(let foodData):
//                processFoodData(foodData, completion: completion)
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
    }
    
    private func processFoodData(_ foodData: [FoodData], completion: @escaping (Result<[Food], Error>) -> Void) {
        foods = foodData.map {
            Food(name: $0.name,
                 description: $0.description,
                 category: .pizza,
                 price: "От \($0.price)",
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
