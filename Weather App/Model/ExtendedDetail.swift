//
//  ExtendedDetail.swift
//  Weather App
//
//  Created by Admin on 02/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum ExtendedDetailCases: String, CaseIterable {
    case sunrise, sunset, chanceOfRain, humidity, wind, feelsLike, pressure, visibility
    
    var description: String {
        var text = ""
        switch self {
        case .chanceOfRain:
            text = "CHANCE OF RAIN"
        case .feelsLike:
            text = "FEELS LIKE"
        default:
            text = self.rawValue.uppercased()
        }
        return text
    }
}

struct ExtendedDetail {
    let sunset: String
    let sunrise: String
    let chanceOfRain: Float
    let humidity: Float
    let wind: Float
    let feelsLileTemp: Int
    let pressure: Float
    let visibility: Int
    let timeZone: Int
}
