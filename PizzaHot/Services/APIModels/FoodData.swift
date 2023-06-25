//
//  FoodData.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import Foundation

struct FoodData: Codable, Equatable {
    let name: String
    let category: String
    let description: String
    let price: Int
    let imageUrl: String
}
