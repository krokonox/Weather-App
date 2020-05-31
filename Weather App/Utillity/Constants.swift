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
    case header, current, hourly, weekDays, currentDetails
    var cellHeight: CGFloat {
        switch self {
        case .header:
            return 200
        case .current:
            return 80
        case .hourly:
            return 70
        case .weekDays:
            return 180
        case .currentDetails:
            return 200
        }
    }
}
