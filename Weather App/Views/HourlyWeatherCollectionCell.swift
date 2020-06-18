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
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return cv
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            self.configureDataSource()
        }
    }
    
    override func setupUI() {
        self.addSubview(collectionView)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {}
    
    private func configureDataSource() {
        collectionView.dataSource = dataSource
    }
}

