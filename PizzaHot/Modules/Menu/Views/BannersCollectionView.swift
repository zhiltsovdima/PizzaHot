//
//  BannersCollectionView.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 23.06.2023.
//

import UIKit

final class BannersCollectionView: UICollectionView {
    
    private var banners = [
        Banner(image: R.Images.banner1),
        Banner(image: R.Images.banner2)
    ]
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = 16
        flowLayout.sectionInset.left = 16
        flowLayout.minimumLineSpacing = 16
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        dataSource = self
        delegate = self
        
        backgroundColor = .clear
        register(BannerCell.self, forCellWithReuseIdentifier: R.Identifiers.bannerCell)
        showsHorizontalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource

extension BannersCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.Identifiers.bannerCell, for: indexPath) as? BannerCell
        else { fatalError("Failed downcasting to BannerCell") }
        
        let banner = banners[indexPath.item]
        cell.setup(with: banner)
        return cell
    }
}
    
// MARK: - UICollectionViewDelegateFlowLayout
 
extension BannersCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 115)
    }
}

