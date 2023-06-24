//
//  FoodCategory.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 24.06.2023.
//

import Foundation

enum FoodCategory: CaseIterable {
    case pizza
    case combo
    case desserts
    case drinks
    
    var description: String {
        switch self {
        case .combo: return "Комбо"
        case .desserts: return "Десерты"
        case .drinks: return "Напитки"
        case .pizza: return "Пицца"
        }
    }
    
    func getOrderNumber() -> Int {
        switch self {
        case .pizza: return 0
        case .combo: return 1
        case .desserts: return 2
        case .drinks: return 3
        }
    }
}
