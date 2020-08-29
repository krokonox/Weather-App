//
//  DataSourceCell.swift
//  Weather App
//
//  Created by Admin on 01/06/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class DataSourceCell: UICollectionViewCell {
    
    public var dataSourceItem: Any?
    
    public let separatorLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        lineView.isHidden = true
        return lineView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    open func setupUI() {
        clipsToBounds = true
        self.backgroundColor = .clear
        self.addSubview(separatorLineView)
        self.separatorLineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
