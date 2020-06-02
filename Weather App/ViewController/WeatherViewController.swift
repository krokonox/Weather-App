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
    var dataSource = WeatherCollectionDataSource()
    
    let dispatch = DispatchGroup()
    
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
    
    lazy var collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.width
        let layout = WeatherCollectionViewLayout()
        layout.headerSize = CGSize(width: width, height: WeatherCellHeight.header.cellHeight)
        layout.todayWeatherCell = CGSize(width: width, height: WeatherCellHeight.current.cellHeight)
        layout.weeklyWeatherCell = CGSize(width: width, height: WeatherCellHeight.weekDays.cellHeight)
        layout.summuryWeatherCell = CGSize(width: width, height: WeatherCellHeight.hourly.cellHeight)
        layout.extendedInfoWeatherCell = CGSize(width: width, height: WeatherCellHeight.currentDetails.cellHeight)
        
        let cv = UICollectionView()
        cv.collectionViewLayout = layout
        cv.register(WeatherHeaderView.self,
                    forSupplementaryViewOfKind: WeatherCollectionViewLayout.ElementType.WeatherHeaderView.kind,
        withReuseIdentifier: WeatherCollectionViewLayout.ElementType.WeatherHeaderView.id)
        
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.addSubview(indicatorView)
        self.requestsMade()
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
    
    private func requestsMade() {
        self.fetchWeather()
        
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.indicatorView.stopAnimating()
            self?.setupViews()
        }
    }
    
    private func fetchWeather() {
        APIClient.sh.fetchHourlyWeather(at: "berlin")  {[weak self] hourlyweather, error in
            self?.dispatch.enter()
            DispatchQueue.main.async {
                if let weather = hourlyweather {
                    self?.dataSource.hourlyWeather = weather.list
                    self?.dispatch.leave()
                } else {
                    self?.alert(message: error?.description ?? "")
                    self?.dispatch.leave()
                }
            }
        }
        
        APIClient.sh.fetchCurrentWeather(at: "berlin") { [weak self] currentweather, error in
            self?.dispatch.enter()
            DispatchQueue.main.async {
                if let weather = currentweather {
                    self?.dataSource.currentWeather = weather
                    self?.dispatch.leave()
                } else {
                    self?.alert(message: error?.description ?? "")
                    self?.dispatch.leave()
                }
            }
        }
    }
}

