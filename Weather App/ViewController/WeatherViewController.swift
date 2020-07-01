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
    private let dispatch = DispatchGroup()
    private let locationManager = CLLocationManager()
    
    private var dataSource = WeatherCollectionDataSource()
    
    private var currentWeather: CurrentWeather?
    private var hourlyWeather: [HourlyWeather] = []
    
    private var latitude = ""
    private var longitude = ""
    var city = "" {
        didSet {
            self.requestsMade(request: .city)
        }
    }

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
    }
    
    private func setupViews() {
        self.view.addSubview(collectionView)
        self.collectionView.addSubview(refreshControl)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func set(currentWeather: CurrentWeather, hourlyWeather: [HourlyWeather]) {
        self.dataSource.currentWeather = currentWeather
        self.dataSource.hourlyWeather = hourlyWeather
        self.setupViews()
        self.collectionView.reloadData()
    }
    
    @objc func refresh() {
        if city == "" {
            self.requestsMade(request: .coordinates)
        } else {
            self.requestsMade(request: .coordinates)
        }
        self.refreshControl.endRefreshing()
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: view.frame.width, height: 1180)
    }
}

extension WeatherViewController: WeatherDelegate {
    func weatherDidLoad(currentWeather: CurrentWeather,
                        hourlyweather: [HourlyWeather],
                        latitude: String,
                        longitude: String) {
        self.set(currentWeather: currentWeather, hourlyWeather: hourlyweather)
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension WeatherViewController {
    private func requestsMade(request: RequestType) {
        if request == .city {
            self.fetchWeather(URLParameters.getByCity(city: self.city).parameters)
        } else {
            self.fetchWeather(URLParameters.getByCoordinates(latitude: self.latitude, longitude: self.longitude).parameters)
        }
        self.dispatch.notify(queue: .main) { [weak self] in
            guard let current = self?.currentWeather, let self = self else { return }
            self.dataSource.currentWeather = current
            self.dataSource.hourlyWeather = self.hourlyWeather
            self.collectionView.reloadData()
        }
    }

    private func fetchWeather(_ parameters: [String : String]) {
        self.dispatch.enter()
        APIClient.sh.fetchHourlyWeather(with: parameters)  { [weak self] hourlyweather, error in
            if let weather = hourlyweather {
                self?.hourlyWeather = weather.list
                self?.dispatch.leave()
            } else {
                self?.alert(message: error?.description ?? "")
                self?.dispatch.leave()
            }
        }
        self.dispatch.enter()
        APIClient.sh.fetchCurrentWeather(with: parameters) { [weak self] currentweather, error in
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

extension WeatherViewController: CitiesTableViewDelegate {
    func cityDidSelected(_ city: String) {
        self.city = city
        requestsMade(request: .city)
    }
}
