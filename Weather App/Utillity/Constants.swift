//
//  Constants.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct NetworkConstants {
    static let apiKey = "9dd287677c80653d5ff5ac9a2a9f7985"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    struct ParameterKeys {}
    struct ParameterValues {}
    
    enum UrlPath: String {
        case current = "weather"
        case forecast = "forecast"
    }
}

enum WeatherCellHeight: Int {
    case header, today, current, hourly, weekDays, summury, currentDetails
    var cellHeight: CGFloat {
        switch self {
        case .header:
            return 200
        case .today:
            return 40
        case .current:
            return 80
        case .hourly:
            return 110
        case .weekDays:
            return 290
        case .summury:
            return 60
        case .currentDetails:
            return 340
        }
    }
}

enum TempUnits: Int {
    case celsius, fahrenheit
    
    var decsription: String {
        switch self {
        case .celsius:
            return "C"
        case .fahrenheit:
            return "F"
        }
    }
}

enum TempSign: String {
    case withSign, withoutSign
    
    var description: String {
        switch self {
        case .withSign:
            return "°"
        case .withoutSign:
            return ""
        }
    }
}

enum DistanceUnit: Int {
    case meter, mile
}

enum Cities: String, CaseIterable {
    case lviv = "Lviv", moscow = "Moscow", paris = "Paris", berlin = "Berlin", capetown = "Capetown"
}
