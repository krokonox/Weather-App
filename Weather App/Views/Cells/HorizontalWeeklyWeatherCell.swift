//
//  HorizontalWeeklyWeatherCell.swift
//  Weather App
//
//  Created by Admin on 05/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HorizontalWeeklyWeatherCell: DataSourceCell {
    
    private lazy var dayNameLabel: WhiteLabel = {
        let day = WhiteLabel()
        day.font = UIFont.systemFont(ofSize: 19, weight: .thin)
        return day
    }()
    
    private lazy var maxTempLabel: WhiteLabel = {
        let temp = WhiteLabel()
        temp.font = UIFont.systemFont(ofSize: 19, weight: .thin)
        return temp
    }()
    
    private lazy var minTempLabel: WhiteLabel = {
        let temp = WhiteLabel()
        temp.font = UIFont.systemFont(ofSize: 19, weight: .thin)
        return temp
    }()
    
    private lazy var iconImageView = UIImageView()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weather = dataSourceItem as? WeeklyWeatherViewModel else { return }
            self.set(viewModel: weather)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(dayNameLabel)
        self.addSubview(maxTempLabel)
        self.addSubview(minTempLabel)
        self.addSubview(iconImageView)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
          
    }
    
    private func set(viewModel: WeeklyWeatherViewModel) {
        self.dayNameLabel.text = viewModel.day
        self.maxTempLabel.text = viewModel.maxTemperature
        self.minTempLabel.text = viewModel.minTemperature
        self.iconImageView.image = viewModel.icon
    }
}
