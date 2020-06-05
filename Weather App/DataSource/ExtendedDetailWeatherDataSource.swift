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
        return info.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let text = viewModel.setupString(detail: info[indexPath.row])
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtendedDetailWeatherCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? ExtendedDetailWeatherCell {
            cell.dataSourceItem = text
        }
        return cell
    }
}
