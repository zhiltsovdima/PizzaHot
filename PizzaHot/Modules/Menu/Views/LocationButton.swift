//
//  LocationButton.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 23.06.2023.
//

import UIKit

final class LocationButton: UIButton {
    
    private let stackView = UIStackView()
    
    private let title = UILabel()
    private let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        backgroundColor = .clear
        
        title.text = "Москва"
        title.font = .boldSystemFont(ofSize: 18)
        icon.image = R.Images.downIcon
        icon.contentMode = .scaleAspectFit
    }
    
    private func setupViews() {
        makeSystemAnimation()
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        [title, icon].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
