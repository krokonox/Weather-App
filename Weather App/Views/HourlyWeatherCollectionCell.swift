//
//  HourlyWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HourlyWeatherCollectionCell: DataSourceCell {
    
    let dataSource = HourlyWeatherCollectionDataSource()
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        return cv
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            self.configureDataSource()
        }
    }
    
    private func configureDataSource() {
        collectionView.dataSource = dataSource
    }
}

