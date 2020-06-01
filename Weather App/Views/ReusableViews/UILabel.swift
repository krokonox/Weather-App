//
//  UILabel.swift
//  Weather App
//
//  Created by Admin on 01/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WhiteLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.textColor = .white
        self.font = UIFont.systemFont(ofSize: 18)
    }
}
