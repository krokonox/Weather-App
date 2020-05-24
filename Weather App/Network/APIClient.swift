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
    
    func request<T: Decodable>(at city: String,
                               with urlPath: NetworkConstants.UrlPath,
                               completionHandler completion: @escaping (_ response: T?, _ error: ResponseError?) -> ()) {
        let url = "\(NetworkConstants.baseUrl)\(urlPath.rawValue)"
        
        var urlComponents: URLComponents? {
            var components = URLComponents(string: url)
            let queryItems = [URLQueryItem(name: "q", value: city),
                              URLQueryItem(name: "appid", value: NetworkConstants.apiKey)]
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
    
    func fetchCurrentWeather(at city: String, completionHandler completion: @escaping(CurrentWeatherCompletion) ) {
        self.request(at: city, with: .current) { (weather: CurrentWeather?, error) in
            completion(weather, error)
        }
    }
    
    func fetchHourlyWeather(at city: String, completionHandler completion: @escaping(HourlyWeatherCompletion)) {
        self.request(at: city, with: .forecast) { (weather: HourlyWeatherResponse?, error) in
            completion(weather, error)
        }
    }
}
