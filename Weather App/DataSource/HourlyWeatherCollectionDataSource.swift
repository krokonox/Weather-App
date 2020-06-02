//
//  HourlyWeatherCollectionDataSource.swift
//  Weather App
//
//  Created by Admin on 02/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HourlyWeatherCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var items: [HourlyWeather] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalHourlyWeatherCollectionCell.reuseIdentifier,
                                                      for: indexPath) as! VerticalHourlyWeatherCollectionCell
        return cell
    }
}
