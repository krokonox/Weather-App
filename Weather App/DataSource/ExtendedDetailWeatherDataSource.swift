//
//  ExtendedDetailWeatherDataSource.swift
//  Weather App
//
//  Created by Admin on 04/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ExtendedDetailWeatherDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let info: [ExtendedDetailCases] = ExtendedDetailCases.allCases
    var viewModel: ExtendedDetailViewModel?
    
    
//     required init(weatherModel: ExtendedDetail) {
//        self.viewModel = ExtendedDetailViewModel(weatherModel: weatherModel)
//        print("init")
//    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var detail: [ExtendedDetailCases : String] = [:]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtendedDetailWeatherCell.reuseIdentifier, for: indexPath) as! ExtendedDetailWeatherCell
        let text = viewModel?.setupString(detail: info[indexPath.row])
        detail[info[indexPath.row]] = text
        cell.dataSourceItem = detail

        return cell
    }
}
