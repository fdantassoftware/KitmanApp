//
//  jsonpARSER.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import Foundation


enum ParseResult<T> {
    case success(T)
    case failure(Error)
}

class JsonParser: NSObject {
    
    static func parseData<K: Codable>(_ data: Data, completion: @escaping (ParseResult<K>) -> Void) {
        do {
            let objects = try JSONDecoder().decode(K.self, from: data)
            let result: ParseResult<K> = ParseResult.success(objects)
            completion(result)
        } catch let error {
            completion(.failure(error))
        }
    }
}
