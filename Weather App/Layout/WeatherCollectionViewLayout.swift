//
//  WeatherCollectionViewLayout.swift
//  Weather App
//
//  Created by Admin on 23/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class WeatherCollectionViewLayout: UICollectionViewLayout {
    enum ElementType: String {
        case WeatherHeaderView
        case TodayWeather
        case HoyrlyWeather
        case WeatherByDays
        case ExtendedInfoWeather
    }
    
    var attributes: [UICollectionViewLayoutAttributes] = []
    
    override class var layoutAttributesClass: AnyClass {
        return WeatherCollectionLayoutAttributes.self
    }
    
    private var collectionViewHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.height
    }
    
    private var collectionViewWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.frame.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    private let numberOfColumn = 4
    private var oldBounds: CGRect = .zero
    private var cache: [WeatherCollectionLayoutAttributes] = []
    private var contentHeight = CGFloat()
    private var zIndex = 0
    
    private var contentOffset: CGPoint {
        guard let collectionView = collectionView else { return CGPoint.zero }
        return collectionView.contentOffset
    }
    
    var headerSize: CGSize = .zero
    var todayWeatherCell: CGSize = .zero
    var hourlyWeatherCell: CGSize = .zero
    var weeklyWeatherCell: CGSize = .zero
    var extendedInfoWeatherCell: CGSize = .zero
    
    override func prepare() {
        super.prepare()
        attributes = []
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        let numberOfRows = collectionView.numberOfSections
        for row in 0..<numberOfRows {
            
            let numberOfColumns = collectionView.numberOfItems(inSection: row)
            for item in 0..<numberOfColumns {
                let indexPath = IndexPath(item: item, section: row)
                
                if let attribute = layoutAttributesForItem(at: indexPath) {
                    attributes.append(attribute)
                }
            }
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if oldBounds.size != newBounds.size {
            cache.removeAll(keepingCapacity: true)
        }
        return true
    }
    
    func prepareCache() {}
}


extension WeatherCollectionViewLayout {
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        <#code#>
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        <#code#>
    }
}
