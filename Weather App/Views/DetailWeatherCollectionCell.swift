//
//  DetailWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DetailWeatherCollectionCell: DataSourceCell {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let currentWeather = dataSourceItem as? CurrentWeather else { return }
            self.set(weather: currentWeather)
        }
    }
    
    private func setupUI() {}
    private func setupConstraints() {}
    private func set(weather: CurrentWeather) {}
}
