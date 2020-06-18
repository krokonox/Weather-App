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
    
    override func setupUI() {
        super.setupUI()
        
        self.addSubview(hourLabel)
        self.addSubview(humidityLabel)
        self.addSubview(weatherIcon)
        self.addSubview(temperatureLabel)
        
        self.setupConstraints()
    }
    private func setupConstraints() {
        self.hourLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(humidityLabel.snp.top).offset(5)
        }
        
        self.humidityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hourLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
        
        self.weatherIcon.snp.makeConstraints { (make) in
            make.top.equalTo(humidityLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(temperatureLabel.snp.top).offset(10)
        }
        
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherIcon.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
