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
    
    let dataSource = WeeklyWeatherDataSource()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(HorizontalWeeklyWeatherCell.self, forCellWithReuseIdentifier: HorizontalWeeklyWeatherCell.reuseIdentifier)
        cv.dataSource = dataSource
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.isScrollEnabled = false
        return cv
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weatherViewModels = dataSourceItem as? [WeatherDay] else { return }
            self.configureDataSoursce(viewModels: weatherViewModels)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureDataSoursce(viewModels: [WeatherDay]) {
        let weatherViewModels = WeatherHelper.getArrayOfWeeklyViewModels(weather: viewModels)
        self.dataSource.viewModel = weatherViewModels
        self.collectionView.reloadData()
    }
}

extension WeeklyWeatherCollectionCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width - 2 * 16), height: 68)
    }
}

