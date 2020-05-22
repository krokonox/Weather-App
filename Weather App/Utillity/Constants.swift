//
//  Constants.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let apiKey = "9dd287677c80653d5ff5ac9a2a9f7985"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    struct ParameterKeys {}
    struct ParameterValues {}
    
    enum UrlPath: String, CaseIterable {
        case weather = "weather"
        case forecast = "forecast"
    }
}
