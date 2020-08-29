//
//  HorizontalWeeklyWeatherCell.swift
//  Weather App
//
//  Created by Admin on 05/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class HorizontalWeeklyWeatherCell: DataSourceCell {
    
    private lazy var containerView: UIView = UIView()
    
    private lazy var dayNameLabel: WhiteLabel = {
        let day = WhiteLabel()
        day.textAlignment = .left
        day.font = UIFont.systemFont(ofSize: 19, weight: .thin)
        return day
    }()
    
    private lazy var tempLabel: WhiteLabel = {
        let temp = WhiteLabel()
        temp.textAlignment = .right
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
    
    override func setupUI() {
        super.setupUI()

        self.addSubview(containerView)
        self.containerView.addSubview(dayNameLabel)
        self.containerView.addSubview(tempLabel)
        self.containerView.addSubview(iconImageView)
        
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.containerView.snp.makeConstraints { (make ) in
           // make.edges.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        
        self.dayNameLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(iconImageView.snp.left)
        }
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.tempLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
        }
    }
    
    private func set(viewModel: WeeklyWeatherViewModel) {
        self.dayNameLabel.text = viewModel.day
        self.tempLabel.text = viewModel.temperatureString
        self.iconImageView.image = viewModel.icon
    }
}
