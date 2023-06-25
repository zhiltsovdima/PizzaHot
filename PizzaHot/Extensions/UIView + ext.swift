//
//  UIView + ext.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 25.06.2023.
//

import UIKit

extension UIView {
    
    func addUpperBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.frame = CGRect(x: 0,
                                 y: 0,
                                 width: frame.width,
                                 height: height)
        addSubview(separator)
    }
}
