//
//  Food.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

final class Food {
    let name: String
    let description: String
    let category: FoodCategory
    let price: String
    var imageUrl: String?
    var image: UIImage?
    
    var isImageLoaded = false
    
    init(name: String, description: String, category: FoodCategory, price: String, imageUrl: String?, image: UIImage? = nil) {
        self.name = name
        self.description = description
        self.category = category
        self.price = price
        self.imageUrl = imageUrl
        self.image = image
    }
}
