//
//  APIEndpoint.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import Foundation

enum APIEndpoints {
    
    case food
    
    private var scheme: String {
        return "https"
    }
    
    private var host: String {
        switch self {
        case .food:
            return "run.mocky.io"
        }
    }
    
    private var path: String {
        switch self {
        case .food:
            return "/"
        }
    }
}

// MARK: - Creating URLRequest

extension APIEndpoints {
    
    func makeURLRequest() -> URLRequest {
        let url = URL(scheme: scheme, host: host, path: path)
        guard let url else { fatalError("Invalid URL") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
    
