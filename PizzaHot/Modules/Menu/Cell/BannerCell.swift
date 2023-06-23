//
//  BannerCell.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 23.06.2023.
//

import UIKit

final class BannerCell: UICollectionViewCell {
    
    private let bannerImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with banner: Banner) {
        bannerImage.image = banner.image
    }
    
    private func setupViews() {
        backgroundColor = .clear
        layer.cornerRadius = 20
        clipsToBounds = true
        
        addSubview(bannerImage)
        bannerImage.contentMode = .scaleAspectFill
        
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: topAnchor),
            bannerImage.leftAnchor.constraint(equalTo: leftAnchor),
            bannerImage.rightAnchor.constraint(equalTo: rightAnchor),
            bannerImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
