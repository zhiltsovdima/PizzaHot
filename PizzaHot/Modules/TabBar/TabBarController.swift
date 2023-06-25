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
        tabBar.tintColor = R.Colors.accent
        tabBar.backgroundColor = R.Colors.backgrorund
        tabBar.addUpperBorder(with: .lightGray.withAlphaComponent(0.5), height: 0.5)
    }
}
