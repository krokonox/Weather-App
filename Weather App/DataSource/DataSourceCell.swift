//
//  DataSourceCell.swift
//  Weather App
//
//  Created by Admin on 01/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class DataSourceCell: UICollectionViewCell {
    
    public var dataSourceItem: Any?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    open func setupUI() {
        clipsToBounds = true
        self.backgroundColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
