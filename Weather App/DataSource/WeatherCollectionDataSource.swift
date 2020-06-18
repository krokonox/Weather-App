//
//  WeatherCollectionDataSource.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeatherCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var weatherForecast: [WeatherDay] = []
    var hourlyWeather: [HourlyWeather] = [] {
        didSet {
            weatherForecast = WeatherHelper.getArrayofDays(array: hourlyWeather)
        }
    }
    var currentWeather: CurrentWeather! 
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: WeatherCollectionViewLayout.ElementType.WeatherHeaderView.kind, withReuseIdentifier: WeatherCollectionViewLayout.ElementType.WeatherHeaderView.id, for: indexPath) as! WeatherHeaderView
        header.weather = currentWeather
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayWeatherCell.reuseIdentifier, for: indexPath) as! TodayWeatherCell
            cell.dataSourceItem =  TodayWeatherViewModel(weatherModel: currentWeather)
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.reuseIdentifier, for: indexPath) as! HourlyWeatherCollectionCell
            cell.dataSource.items = hourlyWeather
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionCell.reuseIdentifier, for: indexPath) as! WeeklyWeatherCollectionCell
            let weekDays = WeatherHelper.getArrayofDays(array: hourlyWeather)
            
            cell.dataSourceItem = weekDays
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummuryWeatherCollectionCell.reuseIdentifier, for: indexPath) as! SummuryWeatherCollectionCell
            cell.dataSourceItem = SummuryWeatherViewModel(weatherModel: currentWeather)
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtendedDetailWeatherCollectionCell.reuseIdentifier, for: indexPath) as! ExtendedDetailWeatherCollectionCell
            cell.dataSourceItem = currentWeather
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
