//
//  DetailWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ExtendedDetailWeatherCollectionCell: DataSourceCell {
    
    let dataSource = ExtendedDetailWeatherDataSource()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = dataSource
        cv.isScrollEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.register(ExtendedDetailWeatherCell.self, forCellWithReuseIdentifier: ExtendedDetailWeatherCell.reuseIdentifier)
        return cv
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let currentWeather = dataSourceItem as? CurrentWeather else { return }
            self.set(weather: currentWeather)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.collectionView.reloadData()
    }
  
    private func set(weather: CurrentWeather) {
        let extendedDetail = ExtendedDetail(weather: weather)
        let viewModel = ExtendedDetailViewModel(weatherModel: extendedDetail)
        self.dataSource.viewModel = viewModel
        self.collectionView.reloadData()
    }
}

extension ExtendedDetailWeatherCollectionCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width - 2 * 16) / 2, height: 68)
    }
}
