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
    
    var weather: CurrentWeather? {
        didSet {
            guard let data = weather else { return }
            self.set(weather: data)
        }
    }
    
    private lazy var cityLabel: WhiteLabel = {
        let city = WhiteLabel()
        city.font = UIFont.systemFont(ofSize: 21)
        return city
    }()
    
    private lazy var desciptionLabel: WhiteLabel = {
        let descripton = WhiteLabel()
        descripton.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return descripton
    }()
    
    private lazy var temperatureLabel: WhiteLabel = {
        let temp = WhiteLabel()
        temp.font = UIFont.systemFont(ofSize: 88, weight: .thin)
        return temp
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        self.setupUI()
    }
    
    private func setupUI() {
        self.addSubview(stackView)
        self.backgroundColor = .clear
        self.stackView.addArrangedSubview(cityLabel)
        self.stackView.addArrangedSubview(desciptionLabel)
        self.stackView.addArrangedSubview(temperatureLabel)
        
        self.stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(45)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview()
        }
    }
    
    private func set(weather: CurrentWeather) {
        self.cityLabel.text = weather.name
        self.desciptionLabel.text = weather.weather.first?.description
        self.temperatureLabel.text = """
        \(WeatherHelper.convertTemperature(temperature: Int(weather.main.temp),
        unit: .celsius,
        unitSign: .withSign))
        """
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let weatherLayoutAttributes = layoutAttributes as? WeatherCollectionLayoutAttributes else { return }
        cityLabel.alpha = weatherLayoutAttributes.headerAlpha
        desciptionLabel.alpha = weatherLayoutAttributes.headerAlpha
        temperatureLabel.alpha = weatherLayoutAttributes.headerAlpha
    }
}
