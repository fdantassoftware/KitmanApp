//
//  NetworkManager.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import Foundation


enum Result {
    case success(Data)
    case failure(Error)
}


class NetworkManager {
    
    static func get(url: URL, completion: @escaping (Result) -> Void) {
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
            } else if let jsonData = responseData {
                completion(.success(jsonData))
            } else {
                // Custom error to handle invalid data
                completion(.failure(NSError(domain: "", code: -200, userInfo: nil)))
            }
        }
        task.resume()
    }
    
    static func post(url: URL, parameters: [String:Any], completion: @escaping (Result) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession(configuration: URLSessionConfiguration.default)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            completion(.failure(error))
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                completion(.failure(error))
            } else if let jsonData = responseData {
                completion(.success(jsonData))
            } else {
                // Custom error to handle invalid data
                completion(.failure(NSError(domain: "", code: -200, userInfo: nil)))
            }
        }
        task.resume()
    }
}

