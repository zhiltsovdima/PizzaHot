//
//  R.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

enum R {
    
    enum Strings {
        
        enum TabBar {
            static let menu = "Меню"
            static let contacts = "Контакты"
            static let profile = "Профиль"
            static let cart = "Корзина"
        }
    }
    
    enum Images {
        static let menuIcon = UIImage(systemName: "fork.knife")
        static let contactsIcon = UIImage(systemName: "mappin")
        static let profileIcon = UIImage(systemName: "person.fill")
        static let cartIcon = UIImage(systemName: "cart.fill")
        
        static let defaultFood = UIImage(systemName: "takeoutbag.and.cup.and.straw")!
    }
    
    enum Colors {
        static let tabBarBackgrorund = UIColor.white
        static let tabBarTint = UIColor.systemPink
    }
    
    enum Identifiers {
        static let foodCell = "FoodCell"
    }
}
