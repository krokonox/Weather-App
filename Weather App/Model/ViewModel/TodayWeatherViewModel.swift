//
//  TodayWeatherViewModel.swift
//  Weather App
//
//  Created by Admin on 17/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct TodayWeatherViewModel {
    let weatherModel: CurrentWeather
    
    var day: String {
        return "\(WeatherHelper.getCurrentDay())  Today"
    }
    var minTemperature: String {
        return WeatherHelper.convertTemperature(temperature: Int(weatherModel.main.temp_min), unit: .celsius, unitSign: .withoutSign)
    }
    var maxTemperature: String {
        return WeatherHelper.convertTemperature(temperature: Int(weatherModel.main.temp_max), unit: .celsius, unitSign: .withoutSign)
    }
    var temperature: String {
        return "\(minTemperature)   \(maxTemperature)"
    }
    
    init(weatherModel: CurrentWeather) {
        self.weatherModel = weatherModel
    }
}
