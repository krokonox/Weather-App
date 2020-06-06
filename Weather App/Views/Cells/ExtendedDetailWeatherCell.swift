//
//  ExtendedDetailWeatherCell.swift
//  Weather App
//
//  Created by Admin on 04/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ExtendedDetailWeatherCell: DataSourceCell {
    
    override var dataSourceItem: Any? {
        didSet {
            guard let detail = dataSourceItem as? [ExtendedDetailCases : String] else { return }
            self.set(extendedDetail: detail)
        }
    }
    
    override func setupUI() {}
    private func set(extendedDetail: [ExtendedDetailCases : String]) {
        
    }
}
