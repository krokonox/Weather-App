//
//  CustomClasses.swift
//  Weather App
//
//  Created by Admin on 02/06/2020.
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

class BackgroundImage: UIImageView {
    override init(frame: CGRect) {
        super.init(image: UIImage(named: "BackgroundClear"))
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.image = UIImage(named: "BackgroundClear")
        self.clipsToBounds = true
    }
}

