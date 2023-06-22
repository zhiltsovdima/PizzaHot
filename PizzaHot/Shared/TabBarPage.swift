//
//  TabBarPage.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit.UIImage

enum TabBarPage {
    case menu
    case contacts
    case profile
    case cart
    
    func pageOrderNumber() -> Int {
        switch self {
        case .menu:
            return 0
        case .contacts:
            return 1
        case .profile:
            return 2
        case .cart:
            return 3
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .menu:
            return R.Images.menuIcon
        case .contacts:
            return R.Images.contactsIcon
        case .cart:
            return R.Images.cartIcon
        case .profile:
            return R.Images.profileIcon
        }
    }
    
    func pageTitle() -> String {
        switch self {
        case .menu:
            return R.Strings.TabBar.menu
        case .contacts:
            return R.Strings.TabBar.contacts
        case .cart:
            return R.Strings.TabBar.cart
        case .profile:
            return R.Strings.TabBar.profile
        }
    }
}
