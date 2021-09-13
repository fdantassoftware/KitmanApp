//
//  Athletes.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import Foundation

struct AthletesResult: Codable {
    var athletes: [Athlete]
}

struct Athlete: Codable {
    
    struct AthleteImage: Codable {
        
        var url: String
    }
    
    var id: Int
    var first_name: String
    var last_name: String
    var username: String
    var squad_ids: [Int]
    var image: AthleteImage
    var squads: [String]?
}
