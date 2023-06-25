//
//  NetworkManagerMock.swift
//  PizzaHotTests
//
//  Created by Dima Zhiltsov on 25.06.2023.
//

import Foundation
@testable import PizzaHot

final class NetworkManagerMock: NetworkManagerProtocol {
    
    var expectedResult: Result<[FoodData], NetworkError>?
    var expextedDataResult: Result<Data, NetworkError>?
        
    func fetchData<T: Decodable>(apiEndpoint: APIEndpoints, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let expectedResult = expectedResult as? Result<T, NetworkError> else { return }
        completion(expectedResult)
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let expextedDataResult else { return }
        completion(expextedDataResult)
    }
}
