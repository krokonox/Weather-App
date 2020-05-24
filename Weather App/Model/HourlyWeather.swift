//
//  HourlyWeather.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct HourlyWeatherResponse: Decodable {
    let list: [HourlyWeather]
}

struct HourlyWeather: Decodable {
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let dt_txt: String
    
//    func returnAsWeatherDay() -> WeatherDay {
//        return WeatherDay(day: WeatherHelper.getWeekDayFromDate(date: dt_txt.returnAsDate() ?? Date()),
//                          humidity: main.humidity,
//                          icon: weather.first?.icon ?? "",
//                          averageTemp: 0)
//    }
}
