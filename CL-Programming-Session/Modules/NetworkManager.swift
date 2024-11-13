//
//  NetworkManager.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case message(_ error: Error?)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return String(localized: "InvalidURL")
        case .invalidData:
            return String(localized: "InvalidData")
        case .invalidResponse:
            return String(localized: "InvalidResponse")
        case .message(let message):
            return message?.localizedDescription
        }
    }
}

class NetworkManager {
    private let baseURL = "https://fakestoreapi.com"

    func getProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        get(type: [Product].self) { result in
            switch result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func get<U: Decodable>(type: U.Type, completion: @escaping (Result<U, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/products") else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let products = try JSONDecoder().decode(U.self, from: data)
                completion(.success(products))
            }
            catch {
                completion(.failure(.message(error)))
            }
        }.resume()
    }

    func getImage(from urlString:String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
