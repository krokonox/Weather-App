//
//  ExtendedDetailWeatherDataSource.swift
//  Weather App
//
//  Created by Admin on 04/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ExtendedDetailWeatherDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let info: [ExtendedDetailCases] = ExtendedDetailCases.allCases
    let viewModel: ExtendedDetailViewModel
    
    required init(viewModel: ExtendedDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.count / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var detail: [ExtendedDetailCases : String] = [:]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtendedDetailWeatherCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? ExtendedDetailWeatherCell {
            for n in indexPath.row...indexPath.row + 2 { // FIX RANGE
                let text = viewModel.setupString(detail: info[n])
                detail[info[indexPath.row]] = text
            }
            cell.dataSourceItem = detail
        }
        return cell
    }
}
