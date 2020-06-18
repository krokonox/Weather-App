//
//  SummuryViewModel.swift
//  Weather App
//
//  Created by Admin on 17/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct SummuryWeatherViewModel {
    let weatherModel: CurrentWeather
    
    var temperature: String {
        return WeatherHelper.convertTemperature(temperature: Int(weatherModel.main.temp), unit: .celsius, unitSign: .withoutSign)
    }
    var minTemperature: String {
        return WeatherHelper.convertTemperature(temperature: Int(weatherModel.main.temp_min), unit: .celsius, unitSign: .withoutSign)
    }
    var maxTemperature: String {
        return WeatherHelper.convertTemperature(temperature: Int(weatherModel.main.temp_max), unit: .celsius, unitSign: .withoutSign)
    }
    var description: String {
        return weatherModel.weather.first?.description ?? ""
    }
    var textDescription: String {
        return "Today: \(description). The high will be \(maxTemperature). The low \(minTemperature). Average temperature is \(temperature)"
    }
    
    init(weatherModel: CurrentWeather) {
        self.weatherModel = weatherModel
    }
}
