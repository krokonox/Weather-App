//
//  WeatherCollectionDataSource.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeatherCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    let weatherForecast: [WeatherDay] = []
    let currentWeather: [CurrentWeather] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayWeatherCell.reuseIdentifier, for: indexPath) as! TodayWeatherCell
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.reuseIdentifier, for: indexPath) as! HourlyWeatherCollectionCell
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyWeatherCollectionCell.reuseIdentifier, for: indexPath) as! WeeklyWeatherCollectionCell
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummuryWeatherCollectionCell.reuseIdentifier, for: indexPath) as! SummuryWeatherCollectionCell
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherCollectionCell.reuseIdentifier, for: indexPath) as! DetailWeatherCollectionCell
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
