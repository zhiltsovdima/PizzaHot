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
        static let menuIcon = UIImage(named: "menu")
        static let contactsIcon = UIImage(named: "contacts")
        static let profileIcon = UIImage(named: "profile")
        static let cartIcon = UIImage(named: "cart")
        
        static let defaultFood = UIImage(systemName: "takeoutbag.and.cup.and.straw")!
        
        static let downIcon = UIImage(named: "downArrow")
        
        static let banner1 = UIImage(named: "banner1")!
        static let banner2 = UIImage(named: "banner2")!
    }
    
    enum Colors {
        static let categoriesBackground = UIColor(hexString: "#F3F5F9")
        static let backgrorund = UIColor.white
        static let accent = UIColor(hexString: "##FD3A69")
        static let buttonSelected = UIColor(hexString: "##FD3A69").withAlphaComponent(0.2)
        static let lightAccent = UIColor(hexString: "#FD3A69").withAlphaComponent(0.4)
    }
    
    enum Identifiers {
        static let foodCell = "FoodCell"
        static let bannerCell = "BannerCell"
        static let categoriesView = "CategoriesView"
        static let categoryCell = "CategoryCell"
    }
}
