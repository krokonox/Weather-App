//
//  SummuryWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SummuryWeatherCollectionCell: DataSourceCell {
    
    lazy var titleLabel: WhiteLabel = WhiteLabel()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weeklyModel = dataSourceItem as? CurrentWeather else { return }
            self.set(weather: weeklyModel)
        }
    }
    
    override func setupUI() {
        self.addSubview(titleLabel)
        self.setupConstraints()
    }
    
    private func setupConstraints() {}
    private func set(weather: CurrentWeather) {
        let temp = weather.main.temp
        let temp_min = weather.main.temp_min
        let temp_max = weather.main.temp_max
        let description = weather.weather.first?.description
        
        titleLabel.text = "Today: \(String(describing: description)). The high will be \(temp_max), the low \(temp_min), average temperature is \(temp)"
    }
}
