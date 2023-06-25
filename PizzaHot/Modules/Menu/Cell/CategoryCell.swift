//
//  CategoryCell.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 23.06.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    private let categoryName = UILabel()
    
    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        updateBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with category: FoodCategory) {
        categoryName.text = category.description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func updateBackgroundColor() {
        backgroundColor = isSelected ? R.Colors.buttonSelected : .clear
        layer.borderColor = isSelected ? R.Colors.buttonSelected.cgColor : R.Colors.lightAccent.cgColor
        categoryName.textColor = isSelected ? R.Colors.accent : R.Colors.lightAccent
        categoryName.font = isSelected ? .boldSystemFont(ofSize: 14) : .systemFont(ofSize: 14)
    }
    
    private func setupViews() {
        backgroundColor = .clear
        layer.borderWidth = 1

        addSubview(categoryName)
        
        categoryName.numberOfLines = 0
        categoryName.font = .systemFont(ofSize: 13)
        categoryName.textAlignment = .center
    }
    
    private func setupConstraints() {
        categoryName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryName.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
