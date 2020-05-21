//
//  Weather.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let weather: [Weather]
    let main: [Main]
    let wind: [Wind]
    let clouds: [Clouds]
    let sys: [Sys]
    let name: String
}

struct Weather {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
}

struct Wind {
    let speed: Float
    let deg: Float
}

struct Clouds {
    let all: Int
}

struct Sys {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
