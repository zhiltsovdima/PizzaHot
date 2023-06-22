//
//  URLComponents + ext.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
