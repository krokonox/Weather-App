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
    
    lazy var titleLabel: WhiteLabel = {
        let title = WhiteLabel()
        return title
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weeklyModel = dataSourceItem as? WeatherDay else { return }
            self.set(weather: weeklyModel)
        }
    }
    
    private func setupUI() {}
    private func setupConstraints() {}
    private func set(weather: WeatherDay) {
        titleLabel.text = weather.day
    }
}

