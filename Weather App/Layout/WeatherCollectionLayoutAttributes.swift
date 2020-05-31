//
//  WeatherCollectionLayoutAttributes.swift
//  Weather App
//
//  Created by Admin on 25/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeatherCollectionLayoutAttributes: UICollectionViewLayoutAttributes {
    var initialOrigin: CGPoint = .zero
    var headerAlpha: CGFloat = .zero
    
    override func copy(with zone: NSZone? = nil) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? WeatherCollectionLayoutAttributes else { return super.copy(with: zone) }
        copiedAttributes.initialOrigin = initialOrigin
        copiedAttributes.headerAlpha = headerAlpha
        return copiedAttributes
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let otherAttributes = object as? WeatherCollectionLayoutAttributes else {
            return false
        }
        if otherAttributes.initialOrigin != initialOrigin || otherAttributes.headerAlpha != headerAlpha {
            return false
        }
        return super.isEqual(object)
    }
}
