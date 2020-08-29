//
//  WeatherHelper.swift
//  Weather App
//
//  Created by Admin on 23/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class WeatherHelper {
    
    static func convertTemperature(temperature: Int, unit: TempUnits, unitSign: TempSign) -> String {
        var temp = 0
        if unit == .celsius {
            temp = temperature - 273
        } else  {
            temp = (temperature - 273) * 9/5 + 32
        }
        return "\(temp) \(unitSign.description)"
    }
    
    static func convertUnixTime(unixTime: Int, timeZone: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let zone = TimeZone(secondsFromGMT: Int(timeZone))
        dateFormatter.timeZone = zone
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeStyle = .short
        return  dateFormatter.string(from: date)
    }
    
    static func getCurrentDay() -> String {
        let date = Date()
        return date.getTodayWeekDay()
    }
    // Complete image names
    static func getWeatherSysName(id: Int, isNight: Bool) -> String {
        var image = ""
        switch id {
        case 200...300:
            image = "ThunderStorm"
        case 300...400:
            image = "Rainy"
        case 500...600:
            if id <= 504 {
                image = "Rainy" }
            else {
                image = "ThunderStorm"
            }
        case 600...700:
            image = "Snow"
        case 800:
            if isNight {
                image = "NightClear"
            } else {
                image = "Sunny"
            }
        case 801...900:
            if isNight {
                image = "NightPartlyCloudy"
            } else {
                image = "DayPartlyCloudy"
            }
        default:
            image = "Sunny"
        }
        return image
    }
    
    static func returnPercentage<T>(number: T) -> String {
        return "\(number) %"
    }
    
    static func convertSpeed() {}
    
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
            
            if index % 8 == 0 {
                let day = item.dt_txt.returnAsDate()
                arr.append(WeatherDay(day: day?.getTodayWeekDay() ?? "",
                                      humidity: humidity / 8,
                                      icon: item.weather.first?.id ?? 0,
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
    
    static func getArrayOfWeeklyViewModels(weather: [WeatherDay]) -> [WeeklyWeatherViewModel] {
        var array: [WeeklyWeatherViewModel] = []
        for item in weather {
            array.append(WeeklyWeatherViewModel(model: item))
        }
        return array
    }
    
    static func getArrayOfHourlyViewModels(weather: [HourlyWeather]) -> [HourlyWeatherViewModel] {
        var array: [HourlyWeatherViewModel] = []
        for item in weather {
            array.append(HourlyWeatherViewModel(viewModel: item))
        }
        return array
    }
}
