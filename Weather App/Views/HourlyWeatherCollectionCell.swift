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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(VerticalHourlyWeatherCollectionCell.self, forCellWithReuseIdentifier: VerticalHourlyWeatherCollectionCell.reuseIdentifier)
        cv.dataSource = dataSource
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        return cv
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weather = dataSourceItem as? [HourlyWeatherViewModel] else { return }
            self.configureDataSource(weather: weather)
        }
    }
    
    override func setupUI() {
        self.addSubview(collectionView)
        separatorLineView.isHidden = false
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureDataSource(weather: [HourlyWeatherViewModel]) {
        self.dataSource.items = weather
        self.collectionView.reloadData()
    }
}

extension HourlyWeatherCollectionCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: self.frame.height - 20)
    }
}

