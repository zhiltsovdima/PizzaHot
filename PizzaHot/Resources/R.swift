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
        
        static let downIcon = UIImage(named: "down")
        
        static let banner1 = UIImage(named: "pizza")!
        static let banner2 = UIImage(named: "cat")!
    }
    
    enum Colors {
        static let tabBarBackgrorund = UIColor.white
        static let accent = UIColor.systemPink
        static let lightAccent = UIColor.systemPink.withAlphaComponent(0.3)
    }
    
    enum Identifiers {
        static let foodCell = "FoodCell"
        static let bannerCell = "BannerCell"
        static let categoriesView = "CategoriesView"
        static let categoryCell = "CategoryCell"
    }
}
