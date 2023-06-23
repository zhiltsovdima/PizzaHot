//
//  TabBarController.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
    }
    
    private func setupAppearance() {
        tabBar.tintColor = R.Colors.tabBarTint
        tabBar.backgroundColor = R.Colors.tabBarBackgrorund
    }
}
