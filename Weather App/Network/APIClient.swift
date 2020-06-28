//
//  APIClient.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class APIClient {
    
    typealias CurrentWeatherCompletion = (CurrentWeather?, ResponseError?) -> Void
    typealias HourlyWeatherCompletion = (HourlyWeatherResponse?, ResponseError?) -> Void
    
    static let sh = APIClient()
 
    private var dataTask: URLSessionDataTask?
    private lazy var session = URLSession(configuration: .default)
    
    private init () {}
    
//    URLQueryItem(name: "lat", value: latitude),
//    URLQueryItem(name: "lon", value: longitude),
//    URLQueryItem(name: "appid", value: NetworkConstants.apiKey)
    
//    latitude: String,
//    longitude: String,
    func request<T: Decodable>(parameters: [String : String],
                               with urlPath: NetworkConstants.UrlPath,
                               completionHandler completion: @escaping (_ response: T?, _ error: ResponseError?) -> ()) {
        let url = "\(NetworkConstants.baseUrl)\(urlPath.rawValue)"
        
        var urlComponents: URLComponents? {
            var components = URLComponents(string: url)
            var queryItems: [URLQueryItem] = []
            parameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: $0.value)) }
            queryItems.append(URLQueryItem(name: "appid", value: NetworkConstants.apiKey))
            
            components?.queryItems = queryItems
            return components
        }
        
        guard let components = urlComponents?.url else { return }
        let request = URLRequest(url: components)
        session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, .invalidURL)
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .parsingError)
                return
            }
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(result, nil)
                    } catch {
                        completion(nil, .parsingError)
                    }
                } else {
                    completion (nil, .parsingError)
                }
            } else {
                completion(nil, .networkError(code: httpResponse.statusCode))
            }
        }.resume()
    }
    
    func fetchCurrentWeather(with parameters: [String: String], completionHandler completion: @escaping(CurrentWeatherCompletion) ) {
        self.request(parameters: parameters, with: .current) { (weather: CurrentWeather?, error) in
            completion(weather, error)
        }
    }
    
    func fetchHourlyWeather(with parameters: [String: String], completionHandler completion: @escaping(HourlyWeatherCompletion)) {
        self.request(parameters: parameters, with: .forecast) { (weather: HourlyWeatherResponse?, error) in
            completion(weather, error)
        }
    }
}
