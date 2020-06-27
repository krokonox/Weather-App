//
//  ViewController.swift
//  Weather App
//
//  Created by Admin on 21/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    let dispatch = DispatchGroup()
    let locationManager = CLLocationManager()
    
    var longitude: String = ""
    var latitude: String = ""
    
    var weather: CurrentWeather?
    var weatherForecast: [HourlyWeather] = []
    
    var dataSource = WeatherCollectionDataSource()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        control.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
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
    
    private lazy var collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.width
       
        let layout = WeatherCollectionViewLayout()
        
        
        layout.itemSize = CGSize(width: width, height: 100)
        layout.headerSize = CGSize(width: width, height: WeatherCellHeight.header.cellHeight)
        layout.todayWeatherCell = CGSize(width: width, height: WeatherCellHeight.current.cellHeight)
        layout.hourlyWeatherCell = CGSize(width: width, height: WeatherCellHeight.hourly.cellHeight)
        layout.weeklyWeatherCell = CGSize(width: width, height: WeatherCellHeight.weekDays.cellHeight)
        layout.summuryWeatherCell = CGSize(width: width, height: WeatherCellHeight.hourly.cellHeight)
        layout.extendedInfoWeatherCell = CGSize(width: width, height: WeatherCellHeight.currentDetails.cellHeight)
        
        
        let cv = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        cv.register(WeatherHeaderView.self,
                    forSupplementaryViewOfKind: WeatherCollectionViewLayout.ElementType.WeatherHeaderView.kind,
                    withReuseIdentifier: WeatherCollectionViewLayout.ElementType.WeatherHeaderView.id)
        cv.register(TodayWeatherCell.self, forCellWithReuseIdentifier: TodayWeatherCell.reuseIdentifier)
        cv.register(HourlyWeatherCollectionCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionCell.reuseIdentifier)
        cv.register(WeeklyWeatherCollectionCell.self, forCellWithReuseIdentifier: WeeklyWeatherCollectionCell.reuseIdentifier)
        cv.register(SummuryWeatherCollectionCell.self, forCellWithReuseIdentifier: SummuryWeatherCollectionCell.reuseIdentifier)
        cv.register(ExtendedDetailWeatherCollectionCell.self, forCellWithReuseIdentifier: ExtendedDetailWeatherCollectionCell.reuseIdentifier)
        
        cv.backgroundView = backgroundImage
        cv.dataSource = dataSource
        cv.delegate = self
        cv.isScrollEnabled = true
        cv.alwaysBounceVertical = true
        cv.showsVerticalScrollIndicator = false
        return cv
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
    
    private func setupViews() {
        self.view.addSubview(collectionView)
        self.collectionView.addSubview(refreshControl)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BackgroundClear")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func requestsMade(latitude: String, longitude: String) {
        self.fetchWeather(latitude: latitude, longitude: longitude)
        
        self.dispatch.notify(queue: .main) { [weak self] in
            self?.dataSource.currentWeather = self?.weather
            self?.dataSource.hourlyWeather = self?.weatherForecast ?? []
            self?.setupViews()
            self?.indicatorView.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
    
    private func fetchWeather(latitude: String, longitude: String) {
        self.dispatch.enter()
        APIClient.sh.fetchHourlyWeather(at: latitude, at: longitude)  {[weak self] hourlyweather, error in
                if let weather = hourlyweather {
                    self?.weatherForecast = weather.list
                    self?.dispatch.leave()
                } else {
                    self?.alert(message: error?.description ?? "")
                    self?.dispatch.leave()
                }
        }
        self.dispatch.enter()
        APIClient.sh.fetchCurrentWeather(at: latitude, at: longitude) { [weak self] currentweather, error in
                if let weather = currentweather {
                    self?.weather = weather
                    self?.dispatch.leave()
                } else {
                    self?.alert(message: error?.description ?? "")
                    self?.dispatch.leave()
                }
            }
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
    
    @objc func refresh() {
        self.requestsMade(latitude: self.latitude, longitude: self.longitude)
        self.refreshControl.endRefreshing()
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: view.frame.width, height: 1180)
    }
}


extension WeatherViewController: CLLocationManagerDelegate {
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

extension WeatherViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings?", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
