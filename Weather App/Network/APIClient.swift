//
//  APIClient.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class APIClient {
    
    typealias CurrentWeatherCompletion = (CurrentWeather?, Error?) -> Void
    typealias HourlyWeatherCompletion = (HourlyWeather?, Error?) -> Void
    
    static let sh = APIClient()
    init () {}
    
    private let apiKey = "9dd287677c80653d5ff5ac9a2a9f7985"
    private let urlPath = "api.openweathermap.org"
    
    func request<T: Decodable>(at cityId: Int,
                               with urlPath: String,
                               completionHandler completion: @escaping(_ response: T?,_ error: Error?) -> ()) {
        
    }
    
    func fetchCurrentWeather(at cityId: Int, completionHandler completion: @escaping(CurrentWeatherCompletion) ) {
        self.request(at: cityId, with: "") { (weather: CurrentWeather?, error) in
            completion(weather, error)
        }
    }
    
    func fetchHourlyWeather(at cityId: Int, completionHandler completion: @escaping(HourlyWeatherCompletion)) {
        self.request(at: cityId, with: "") { (weather: HourlyWeather?, error) in
            completion(weather, error)
        }
    }
}
