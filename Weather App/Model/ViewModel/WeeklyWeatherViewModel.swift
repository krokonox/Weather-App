//
//  WeeklyWeatherViewModel.swift
//  Weather App
//
//  Created by Admin on 05/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct WeeklyWeatherViewModel {
    let viewModel: WeatherDay
    
    var day: String {
        return viewModel.day
    }
    var icon: UIImage? {
        return UIImage(named: WeatherHelper.getWeatherSysName(id: viewModel.icon, isNight: false))
    }
    var minTemperature: String {
        return WeatherHelper.convertTemperature(temperature: viewModel.minTemp, unit: .celsius, unitSign: .withSign)
    }
    var maxTemperature: String {
        return WeatherHelper.convertTemperature(temperature: viewModel.maxTemp, unit: .celsius, unitSign: .withSign)
    }
    
    init(model: WeatherDay) {
        self.viewModel = model
    }
}
