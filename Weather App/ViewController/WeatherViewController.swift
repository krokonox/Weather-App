//
//  ViewController.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    var weather: CurrentWeather?
    var weatherForecast: HourlyWeatherResponse?
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let ativityIndicator = UIActivityIndicatorView()
        ativityIndicator.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        ativityIndicator.center = self.view.center
        ativityIndicator.layer.frame = CGRect(x: 0, y: 0,
                                              width: self.view.frame.width, height: self.view.frame.height)
        ativityIndicator.layer.backgroundColor = UIColor(named: "SkyBlue")?.cgColor
        ativityIndicator.startAnimating()
        ativityIndicator.style = .whiteLarge
        return ativityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setupViews()
        self.view.addSubview(indicatorView)
        self.fetchWeather()
    }
    
    private func setupViews() {
        self.setBackgroundImage()
        self.view.addSubview(indicatorView)
    }
    
    private func setBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundClear")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func fetchWeather() {
        APIClient.sh.fetchHourlyWeather(at: "berlin") { hourlyweather, error in
            DispatchQueue.main.async {
                if let weather = hourlyweather {
                    self.indicatorView.stopAnimating()
                    print(WeatherHelper.getArrayofDays(array: weather.list))
                } else {
                    self.alert(message: error?.description ?? "")
                }
            }
        }
    }
}

