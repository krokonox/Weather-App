//
//  HourlyWeatherViewModel.swift
//  Weather App
//
//  Created by Admin on 19/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct HourlyWeatherViewModel {
    let viewModel: HourlyWeather
    
    var hour: String {
        return "\(viewModel.dt_txt.returnAsDate()?.getHour() ?? "")"
    }
    var icon: UIImage? {
        return UIImage(named: WeatherHelper.getWeatherSysName(id: viewModel.weather.first?.id ?? 0, isNight: false))
    }
    var temperature: String {
        return "\(WeatherHelper.convertTemperature(temperature: Int(viewModel.main.temp), unit: .celsius, unitSign: .withSign))"
    }
    var humidity: String {
        return "\(WeatherHelper.returnPercentage(number: viewModel.main.humidity))"
    }
    init(viewModel: HourlyWeather) {
        self.viewModel = viewModel
    }
}
