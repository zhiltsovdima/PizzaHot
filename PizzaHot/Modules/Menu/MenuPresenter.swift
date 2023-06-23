//
//  MenuPresenter.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import UIKit

protocol MenuPresenterProtocol: AnyObject {
    func updateFoods()
    func numberOfItems() -> Int
    func configure(cell: FoodCellProtocol, at index: Int)
    func willDisplay(cell: FoodCellProtocol, at index: Int)
}

final class MenuPresenter {
    
    private var foods = [Food]()
    
    weak var view: MenuViewProtocol?
    private let interactor: MenuInteractorProtocol
    private let router: AppRouterProtocol
    
    private var imageLoadTask: DispatchWorkItem?
    
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
                foods = loadedFoods
                view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return foods.count
    }
    
    func configure(cell: FoodCellProtocol, at index: Int) {
        guard let food = food(at: index) else { return }
        cell.setup(with: food)
    }
    
    func willDisplay(cell: FoodCellProtocol, at index: Int) {
        guard let food = food(at: index) else { return }
        guard !food.isImageLoaded else {
            cell.updateImage(food.image)
            return
        }
        interactor.fetchImage(for: food) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                food.isImageLoaded = true
                food.image = image
                updateImage(for: cell, image: image)
            case .failure(let error):
                updateImage(for: cell, image: R.Images.defaultFood)
                food.isImageLoaded = false
                print(error)
            }
        }
    }
}

// MARK: - Private Methods

extension MenuPresenter {
    private func food(at index: Int) -> Food? {
        guard index >= 0, index < foods.count else { return nil }
        return foods[index]
    }
    
    private func updateImage(for cell: FoodCellProtocol, image: UIImage) {
        DispatchQueue.main.async {
            cell.updateImage(image)
        }
    }
}
