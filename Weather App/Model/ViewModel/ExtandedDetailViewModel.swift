//
//  DetailWeatherViewModel.swift
//  Weather App
//
//  Created by Admin on 03/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct ExtendedDetailViewModel {
    private var viewModel: ExtendedDetail
    
    init(viewModel: ExtendedDetail) {
        self.viewModel = viewModel
    }
    
    func setupString(detail: ExtendedDetailCases) -> String {
        switch detail {
        case .sunset:
            return WeatherHelper.convertUnixTime(unixTime: Int(viewModel.sunset) ?? 0,
                                                 timeZone: viewModel.timeZone)
        case .sunrise:
            return WeatherHelper.convertUnixTime(unixTime: Int(viewModel.sunrise) ?? 0, timeZone: viewModel.timeZone)
        case .chanceOfRain:
            return WeatherHelper.returnPercentage(number: viewModel.chanceOfRain)
        case .humidity:
            return WeatherHelper.returnPercentage(number: viewModel.humidity)
        case .wind:
            return "\(WeatherHelper.returnPercentage(number: viewModel.visibility)) Meters/s"
        case .feelsLike:
            return WeatherHelper.convertTemperature(temperature: viewModel.feelsLileTemp, unit: .celsius, unitSign: .withSign)
        case .pressure:
            return "\(WeatherHelper.returnPercentage(number: viewModel.pressure)) hPa"
        case .visibility:
            return "\(viewModel.visibility / 1000) Km"
        }
    }
}


