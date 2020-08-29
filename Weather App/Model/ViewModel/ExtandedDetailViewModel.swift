//
//  DetailWeatherViewModel.swift
//  Weather App
//
//  Created by Admin on 03/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct ExtendedDetailViewModel {
    let weatherModel: ExtendedDetail
    
    var sunset: String {
        return WeatherHelper.convertUnixTime(unixTime: Int(weatherModel.sunset) ?? 0,
                                             timeZone: weatherModel.timeZone)
    }
    var sunrise: String {
        return WeatherHelper.convertUnixTime(unixTime: Int(weatherModel.sunrise) ?? 0, timeZone: weatherModel.timeZone)
    }
    var chanceOfRain: String {
        return WeatherHelper.returnPercentage(number: weatherModel.chanceOfRain)
    }
    var humidity: String {
        return WeatherHelper.returnPercentage(number: weatherModel.humidity)
    }
    var wind: String {
        return "\(WeatherHelper.returnPercentage(number: weatherModel.visibility)) Meters/s"
    }
    var feelsLike: String {
        return WeatherHelper.convertTemperature(temperature: weatherModel.feelsLikeTemp, unit: .celsius, unitSign: .withSign)
    }
    var pressure: String {
        return "\(WeatherHelper.returnPercentage(number: weatherModel.pressure)) hPa"
    }
    var visibility: String {
        return "\(weatherModel.visibility / 1000) Km"
    }
    
    init(weatherModel: ExtendedDetail) {
        self.weatherModel = weatherModel
    }
    
    func setupString(detail: ExtendedDetailCases) -> String {
        switch detail {
        case .sunset:
            return WeatherHelper.convertUnixTime(unixTime: Int(weatherModel.sunset) ?? 0,
                                                 timeZone: weatherModel.timeZone)
        case .sunrise:
            return WeatherHelper.convertUnixTime(unixTime: Int(weatherModel.sunrise) ?? 0, timeZone: weatherModel.timeZone)
        case .chanceOfRain:
            return WeatherHelper.returnPercentage(number: weatherModel.chanceOfRain)
        case .humidity:
            return WeatherHelper.returnPercentage(number: weatherModel.humidity)
        case .wind:
            return "\(weatherModel.wind) Meters/s"
        case .feelsLike:
            return WeatherHelper.convertTemperature(temperature: weatherModel.feelsLikeTemp, unit: .celsius, unitSign: .withSign)
        case .pressure:
            return "\(weatherModel.pressure) hPa"
        case .visibility:
            return "\(weatherModel.visibility / 1000) Km"
        }
    }
}


