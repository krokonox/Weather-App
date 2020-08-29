//
//  SummuryWeatherCollectionCell.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SummuryWeatherCollectionCell: DataSourceCell {
    
    private lazy var titleLabel: WhiteLabel = {
        let title = WhiteLabel()
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return title
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let weeklyModel = dataSourceItem as? SummuryWeatherViewModel else { return }
            self.set(weather: weeklyModel)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.addSubview(titleLabel)
        separatorLineView.isHidden = false
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    private func set(weather: SummuryWeatherViewModel) {
        self.titleLabel.text = weather.textDescription
    }
}
