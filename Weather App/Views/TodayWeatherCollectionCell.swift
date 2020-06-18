//
//  TodayWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TodayWeatherCell: DataSourceCell {
    
    private lazy var containerView = UIView()
    private lazy var dayLabel = WhiteLabel()
    private lazy var temperatureLabel = WhiteLabel()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weather = dataSourceItem as? TodayWeatherViewModel else {  return }
            self.set(weather: weather)
        }
    }
    
    override func setupUI() {
        super.setupUI()

        self.addSubview(containerView)
        self.containerView.addSubview(dayLabel)
        self.containerView.addSubview(temperatureLabel)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.containerView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        self.dayLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(temperatureLabel.snp.left).offset(80)
        }
        
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(dayLabel.snp.right).inset(80)
        }
    }
    private func set(weather: TodayWeatherViewModel) {
        self.dayLabel.text = weather.day
        self.temperatureLabel.text = weather.temperature
    }
}
