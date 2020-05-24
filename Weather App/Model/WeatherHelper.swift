//
//  WeatherHelper.swift
//  Weather App
//
//  Created by Admin on 23/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class WeatherHelper {
    
    static func convertTemperature() {}
    static func getWeatherSysName() {}
        
    static func getArrayofDays(array: [HourlyWeather]) -> [WeatherDay] {
        var arr: [WeatherDay] = []
        var index = 1
        var temp_max: Float = 0.00
        var temp_min: Float = 0.00
        var humidity = 0
        
        for item in array {
            temp_max += item.main.temp_max
            temp_min += item.main.temp_min
            humidity += item.main.humidity
            
            if index == 1 || index % 8 == 0 {
                let day = item.dt_txt.returnAsDate()
                arr.append(WeatherDay(day: day?.getTodayWeekDay() ?? "",
                                      humidity: humidity / 8,
                                      icon: item.weather.first?.icon ?? "",
                                      minTemp: Int(temp_min / 8),
                                      maxTemp: Int(temp_max / 8)))
                temp_max = 0.00
                temp_min = 0.00
                humidity = 0
            }
            index += 1
        }
        return arr
    }
}
