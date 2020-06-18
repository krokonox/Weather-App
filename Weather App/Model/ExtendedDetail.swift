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
    let feelsLikeTemp: Int
    let pressure: Float
    let visibility: Int
    let timeZone: Int
    
    init(weather: CurrentWeather) {
        self.sunset = WeatherHelper.convertUnixTime(unixTime: weather.sys.sunset, timeZone: weather.timezone)
        self.sunrise = WeatherHelper.convertUnixTime(unixTime: weather.sys.sunrise, timeZone: weather.timezone)
        self.chanceOfRain = Float(weather.main.humidity)
        self.humidity = Float(weather.main.humidity)
        self.wind = weather.wind.speed
        self.feelsLikeTemp = Int(weather.main.feels_like)
        self.pressure = Float(weather.main.pressure)
        self.visibility = weather.visibility
        self.timeZone = weather.timezone
    }
}
