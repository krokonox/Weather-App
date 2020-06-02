//
//  WeatherHeaderView.swift
//  Weather App
//
//  Created by Admin on 31/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class WeatherHeaderView: UICollectionReusableView {
    
    private lazy var cityLabel: WhiteLabel = {
        let city = WhiteLabel()
        return city
    }()
    
    private lazy var desciptionLabel: WhiteLabel = {
        let descripton = WhiteLabel()
        descripton.font = UIFont.systemFont(ofSize: 11, weight: .thin)
        return descripton
    }()
    
    private lazy var temperatureLabel: WhiteLabel = {
        let temp = WhiteLabel()
        temp.font = UIFont.systemFont(ofSize: 88, weight: .thin)
        return temp
    }()
    
    private lazy var dayLabel: WhiteLabel = {
        let day = WhiteLabel()
        return day
    }()
    
    private lazy var temperatureHighLabel: WhiteLabel = {
        let temp = WhiteLabel()
        return temp
    }()
    
    private lazy var temperatureLowLabel: WhiteLabel = {
        let temp = WhiteLabel()
        return temp
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 0
        return stack
    }()
    
    private func setupViews() {
        self.stackView.addArrangedSubview(temperatureHighLabel)
        self.stackView.addArrangedSubview(temperatureLowLabel)
     
    }
    
    private func setupConstraints() {}
}
