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
        hour.font = UIFont.systemFont(ofSize: 13)
        return hour
    }()
    
    lazy var temperatureLabel: WhiteLabel = {
        let temperature = WhiteLabel()
        temperature.font = UIFont.systemFont(ofSize: 14)
        return temperature
    }()
    
    lazy var humidityLabel: WhiteLabel = {
        let humidity = WhiteLabel()
        humidity.font = UIFont.systemFont(ofSize: 11, weight: .light)
        return humidity
    }()
    
    lazy var weatherIcon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let item = dataSourceItem as? HourlyWeatherViewModel else { return }
            self.set(weather: item)
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
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
           // make.bottom.equalTo(humidityLabel.snp.top).offset(7)
        }
        
        self.humidityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(hourLabel.snp.bottom).offset(5)
//            make.bottom.equalTo(weatherIcon.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.weatherIcon.snp.makeConstraints { (make) in
           // make.height.width.equalTo(9)
            make.top.equalTo(humidityLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            //make.bottom.equalTo(temperatureLabel.snp.top).inset(15)
        }
        
        self.temperatureLabel.snp.makeConstraints { (make) in
            //make.top.equalTo(weatherIcon.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func set(weather: HourlyWeatherViewModel) {
        hourLabel.text = weather.hour
        temperatureLabel.text = weather.temperature
        weatherIcon.image = weather.icon
        humidityLabel.text = weather.humidity
    }
}
