//
//  WeeklyWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class WeeklyWeatherCollectionCell: DataSourceCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        //layout.sectionInset = UIEdgeInsets(top: 10, left: Constraint.margin, bottom: 0, right: Constraint.margin)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weatherViewModels = dataSourceItem as? [WeeklyWeatherViewModel] else { return }
            self.setDataSoursce(viewModels: weatherViewModels)
        }
    }
    
    private func setupUI() {}
    private func setupConstraints() {}
    private func setDataSoursce(viewModels: [WeeklyWeatherViewModel]) {
        let dataSource = WeeklyWeatherDataSource()
        dataSource.viewModel = viewModels
        self.collectionView.dataSource = dataSource
        //self.collectionView.delegate = dataSource
    }
}

