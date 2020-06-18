//
//  ExtendedDetailWeatherCell.swift
//  Weather App
//
//  Created by Admin on 04/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class ExtendedDetailWeatherCell: DataSourceCell {
    
     lazy var textLabel: UITextView = {
        let label = UITextView()
        label.isEditable  = false
        label.backgroundColor = .clear
        label.isScrollEnabled = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .thin)
        label.textColor = .white
        //label.setLineSpacing(lineSpacing: 1.0)
        label.textAlignment = .left
        return label
    }()
    
    override var dataSourceItem: Any? {
        didSet {
            guard let detail = dataSourceItem as? [ExtendedDetailCases : String] else { return }
            self.set(extendedDetail: detail)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.addSubview(textLabel)
        self.textLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func set(extendedDetail: [ExtendedDetailCases : String]) {
        for (key, value) in extendedDetail {
            let attributedText = NSMutableAttributedString.setupString(text: key.description, description: "\n\(value)")
            attributedText.setLineSpacing(1.0)
            textLabel.text = attributedText.string
        }
    }
}
