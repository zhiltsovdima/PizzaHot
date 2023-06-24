//
//  MenuPresenter.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol MenuPresenterProtocol: AnyObject {
    func updateFoods()
    func numberOfSections() -> Int
    func numberOfItems(section: Int) -> Int
    func configure(cell: FoodCellProtocol, at indexPath: IndexPath)
    func willDisplay(cell: FoodCellProtocol, at indexPath: IndexPath)
    
    func scrollToSectionFor(category: FoodCategory)
    func getCategories() -> [FoodCategory]
}

final class MenuPresenter {
    
    weak var view: MenuViewProtocol?
    private let interactor: MenuInteractorProtocol
    private let router: AppRouterProtocol
    
    var foodSections: [FoodCategory: [Food]] = [:]

    init(_ interactor: MenuInteractorProtocol, _ router: AppRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MenuPresenterProtocol

extension MenuPresenter: MenuPresenterProtocol {
    
    func updateFoods() {
        interactor.fetchFood { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let loadedFoods):
                updateFoodSections(with: loadedFoods)
                view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfSections() -> Int {
        return foodSections.keys.count
    }
    
    func numberOfItems(section: Int) -> Int {
        guard let category = foodSections.keys.first(where: { $0.getOrderNumber() == section }) else { return 0 }
        return foodSections[category]?.count ?? 0
    }
    
    func configure(cell: FoodCellProtocol, at indexPath: IndexPath) {
        guard let category = foodSections.keys.first(where: { $0.getOrderNumber() == indexPath.section }),
              let foodsInSection = foodSections[category]
        else { return }
        let food = foodsInSection[indexPath.row]
        cell.setup(with: food)
    }
    
    func willDisplay(cell: FoodCellProtocol, at indexPath: IndexPath) {
        guard let category = foodSections.keys.first(where: { $0.getOrderNumber() == indexPath.section }),
              let foodsInSection = foodSections[category]
        else { return }
        
        let food = foodsInSection[indexPath.row]
        guard !food.isImageLoaded else {
            cell.updateImage(food.image)
            return
        }
        interactor.fetchImage(for: food) { result in
            switch result {
            case .success(let image):
                food.isImageLoaded = true
                food.image = image
                cell.updateImage(image)
            case .failure(let error):
                cell.updateImage(R.Images.defaultFood)
                food.isImageLoaded = false
                print(error)
            }
        }
    }
    
    func getCategories() -> [FoodCategory] {
        return foodSections.keys.sorted(by: { $0.getOrderNumber() < $1.getOrderNumber() })
    }
    
    func scrollToSectionFor(category: FoodCategory) {
        guard let selectedCategory = foodSections.keys.first(where: { $0 == category }) else { return }
        let section = selectedCategory.getOrderNumber()
        view?.scrollTable(to: section)
    }
}

// MARK: - Private Methods

extension MenuPresenter {
    
    private func updateFoodSections(with foods: [Food]) {
        foodSections = [:]
        
        for food in foods {
            foodSections[food.category, default: []]
                .append(food)
        }
    }
}
