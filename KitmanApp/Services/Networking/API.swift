//
//  API.swift
//  KitmanApp
//
//  Created by Fabio Dantas on 13/09/2021.
//


import Foundation

struct API {
    
    static let shared = API()
   
    
    let BASE_URL = "https://kml-tech-test.glitch.me"
    
    var getAthletes: String {
        return "\(BASE_URL)/athletes"
    }
    
    var login: String {
        return "\(BASE_URL)/session"
    }
}

