//
//  WeeklyWeatherDataSoource.swift
//  Weather App
//
//  Created by Admin on 05/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeeklyWeatherDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var viewModel: [WeeklyWeatherViewModel] = [] {
        didSet {
            print("set")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("dsfsfdsf")
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalWeeklyWeatherCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? HorizontalWeeklyWeatherCell {
            cell.dataSourceItem = viewModel[indexPath.row]
        }
        return cell
    }
}
