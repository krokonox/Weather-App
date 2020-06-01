//
//  VerticalHourlyWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 01/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class VerticalHourlyWeatherCollectionCell: DataSourceCell {
    
    lazy var hourLabel: WhiteLabel = {
        let hour = WhiteLabel()
        return hour
    }()
    
    lazy var temperatureLabel: WhiteLabel = {
        let temperature = WhiteLabel()
        return temperature
    }()
    
    lazy var humidityLabel: WhiteLabel = {
        let humidity = WhiteLabel()
        return humidity
    }()
    
    lazy var weatherIcon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let item = dataSourceItem as? HourlyWeather else { return }
            
            hourLabel.text = item.dt_txt.returnAsDate()?.getHour()
            temperatureLabel.text = "\(item.main.temp)"
            humidityLabel.text = "\(item.main.humidity)"
        }
    }
}
