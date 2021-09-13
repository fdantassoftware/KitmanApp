//
//  Squad.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//

import Foundation

struct SquadResult: Codable {
    var squads: [Squad]
}

struct Squad: Codable {
    
    var name: String
    var id: Int
}
