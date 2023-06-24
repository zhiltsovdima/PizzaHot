//
//  CategoriesView.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 23.06.2023.
//

import UIKit

protocol CategoriesViewProtocol: AnyObject {
    func didSelectCategory(_ index: Int)
    func reloadData()
}

final class CategoriesView: UIView {
    
    private var categories = [FoodCategory]()
    
    weak var presenter: MenuPresenterProtocol?
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: R.Identifiers.categoryCell)
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = 20
        flowLayout.sectionInset.left = 20
        flowLayout.minimumLineSpacing = 10
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate

extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifiers.categoryCell, for: indexPath) as? CategoryCell
        else { fatalError("Failed downcasting to CategoryCell") }
        
        cell.setup(with: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        presenter?.scrollToSectionFor(category: selectedCategory)
    }
}

// MARK: - UICollectionView FlowLayout
extension CategoriesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: bounds.height - 10)
    }
}


// MARK: - CategoriesViewProtocol

extension CategoriesView: CategoriesViewProtocol {
    
    func reloadData() {
        guard let presenter else { return }
        categories = presenter.getCategories()
        collectionView.reloadData()
        didSelectCategory(0)
    }
    
    func didSelectCategory(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}
