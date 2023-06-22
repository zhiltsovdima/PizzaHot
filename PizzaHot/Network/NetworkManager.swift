//
//  NetworkManager.swift
//  PizzaHot
//
//  Created by Dima Zhiltsov on 22.06.2023.
//

import Foundation

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

// MARK: - NetworkManagerProtocol

protocol NetworkManagerProtocol {
    func fetchData(apiEndpoint: APIEndpoints, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

// MARK: - NetworkManager

final class NetworkManager: NetworkManagerProtocol {
    
    private let urlSession: URLSession
        
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData(apiEndpoint: APIEndpoints, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = apiEndpoint.makeURLRequest()
        fetchData(request: request, completion: completion)
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let request = URLRequest(url: url)
        fetchData(request: request, completion: completion)
    }
    
    private func fetchData(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            do {
                let safeData = try NetworkError.processResponseData(data, response)
                completion(.success(safeData))
            } catch {
                let netError = error as! NetworkError
                completion(.failure(netError))
            }
        }
        task.resume()
    }
}
