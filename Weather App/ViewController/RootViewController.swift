//
//  RootViewController.swift
//  Weather App
//
//  Created by Admin on 28/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

protocol WeatherDelegate: class {
    func weatherDidLoad(currentWeather: CurrentWeather,
                        hourlyweather: [HourlyWeather],
                        latitude: String,
                        longitude: String)
}

class RootViewController: UIViewController {
    
    private let dispatch = DispatchGroup()
    private let locationManager = CLLocationManager()
    
    private var currentWeather: CurrentWeather?
    private var hourlyWeather: [HourlyWeather] = []
    
    private var latitude: String = ""
    private var longitude: String = ""
    
    weak var delegate: WeatherDelegate?
    
    private lazy var indicatorView: UIActivityIndicatorView = {
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
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "BackgroundClear")
        image.clipsToBounds = true
        return image
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(indicatorView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupLocation()
    }
    
    private func setupLocation() {
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    private func getCurrentLocation() {
        self.locationManager.startUpdatingLocation()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        
        if let coordinates = locationManager.location {
            LocationManager.sh.convertCoordinatesToLocation(coordinares: coordinates) { (location) in
                self.latitude = location.latitude
                self.longitude = location.longitude
                self.requestsMade(latitude: self.latitude, longitude: self.longitude)
            }
        }
    }
    
    private func requestsMade(latitude: String, longitude: String) {
        self.fetchWeather(latitude: latitude, longitude: longitude)
        
        self.dispatch.notify(queue: .main) { [weak self] in
            guard let current = self?.currentWeather, let self = self else { return }

            self.indicatorView.stopAnimating()
            
            Interface.sh.setupTabViewController()
            self.delegate?.weatherDidLoad(currentWeather: current,
                                          hourlyweather: self.hourlyWeather,
                                          latitude: self.latitude,
                                          longitude: self.longitude)
        }
    }
    
    private func fetchWeather(latitude: String, longitude: String) {
        self.dispatch.enter()
        APIClient.sh.fetchHourlyWeather(with: URLParameters.getByCoordinates(latitude: self.latitude, longitude: self.longitude).parameters)  { [weak self] hourlyweather, error in
            if let weather = hourlyweather {
                self?.hourlyWeather = weather.list
                self?.dispatch.leave()
            } else {
                self?.alert(message: error?.description ?? "")
                self?.dispatch.leave()
            }
        }
        self.dispatch.enter()
        APIClient.sh.fetchCurrentWeather(with: URLParameters.getByCoordinates(latitude: self.latitude, longitude: self.longitude).parameters) { [weak self] currentweather, error in
            if let weather = currentweather {
                self?.currentWeather = weather
                self?.dispatch.leave()
            } else {
                self?.alert(message: error?.description ?? "")
                self?.dispatch.leave()
            }
        }
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.getCurrentLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            locationManager.stopUpdatingLocation()
            self.getCurrentLocation()
        }
    }
}
