//
//  FoodCell.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 23.06.2023.
//

import UIKit

protocol FoodCellProtocol: AnyObject {
    func setup(with food: Food)
    func updateImage(_ image: UIImage?)
}

final class FoodCell: UITableViewCell {
    
    private let stackView = UIStackView()
    private let foodImage = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        [foodImage, stackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        stackView.axis = .vertical
        
        [nameLabel, descriptionLabel, priceLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            foodImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            foodImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

extension FoodCell: FoodCellProtocol {
    
    func setup(with food: Food) {
        nameLabel.text = food.name
        descriptionLabel.text = food.description
    }
    
    func updateImage(_ image: UIImage?) {
        foodImage.image = image
    }
}
