//
//  URLPaths.swift
//  Weather App
//
//  Created by Admin on 28/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum URLParameters {
    case getByCoordinates(latitude: String, longitude: String)
    case getByCity(city: String)
    
    var parameters: [String : String] {
        switch self {
        case .getByCity(let city):
            return ["q" : city]
        case .getByCoordinates(let latitude, let longitude):
            return ["lat" : latitude, "lon" : longitude]
        }
    }
}

enum RequestType {
    case city, coordinates
//    
//    var value: URLParameters {
//        switch self {
//        case .city:
//            URLParameters.getByCity(city: <#T##String#>)
//        case .coordinates:
//            return
//    }
}
