//
//  AppRouter.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol AppRouterProtocol: AnyObject {
    func setupRootModule()
}

final class AppRouter {
    private let window: UIWindow
    
    private let tabBarController = TabBarController()
    private let foodService = FoodService()
    
    init(_ window: UIWindow) {
        self.window = window
    }
}

// MARK: - AppRouterProtocol

extension AppRouter: AppRouterProtocol {
    
    func setupRootModule() {
        let pages: [TabBarPage] = [.menu, .cart, .contacts, .profile]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers = pages.map { getController(for: $0)}
        prepareTabBarController(with: controllers)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}

// MARK: - Private methods

extension AppRouter {
    
    private func getController(for page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: page.pageTitle(),
            image: page.pageIcon(),
            tag: page.pageOrderNumber()
        )
        switch page {
        case .menu:
            let interactor = MenuInteractor(foodService: foodService)
            let presenter = MenuPresenter(interactor, self)
            let controller = MenuViewController(presenter)
            presenter.view = controller
            navigationController.setViewControllers([controller], animated: false)
        default:
            break
        }
        return navigationController
    }
    
    private func prepareTabBarController(with controllers: [UIViewController]) {
        tabBarController.setViewControllers(controllers, animated: false)
    }
}

