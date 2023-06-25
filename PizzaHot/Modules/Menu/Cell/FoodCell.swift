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
        backgroundColor = R.Colors.backgrorund
        
        [foodImage, stackView, priceLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        [nameLabel, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        nameLabel.font = .boldSystemFont(ofSize: 17)
        nameLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        
        priceLabel.backgroundColor = .clear
        priceLabel.textColor = R.Colors.accent
        priceLabel.font = .systemFont(ofSize: 13)
        priceLabel.textAlignment = .center
        priceLabel.layer.borderColor = R.Colors.accent.cgColor
        priceLabel.layer.borderWidth = 1
        priceLabel.layer.cornerRadius = 5
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            foodImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            foodImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            foodImage.widthAnchor.constraint(equalTo: foodImage.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            nameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
    
            priceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 87),
            priceLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

extension FoodCell: FoodCellProtocol {
    
    func setup(with food: Food) {
        nameLabel.text = food.name
        descriptionLabel.text = food.description
        priceLabel.text = food.price
    }
    
    func updateImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            foodImage.image = image
        }
    }
}
